clear;

% 读取图片
rgb = imread('bird_GT2.bmp');
% figure(1);
% imshow(rgb);

% 将图片由rgb转换为yuv
yuv = rgb2ycbcr(rgb);
yOri = yuv(:,:,1);

% 补全图片长宽为8的倍数
blockSize = 8;
[m, n, k] = size(yuv);
mOri = m;
nOri = n;
numBlocksM = ceil(m / blockSize);
numBlocksN = ceil(n / blockSize);
if(numBlocksM * blockSize ~= m)
    for i = m+1 : numBlocksM*blockSize
        yuv(i, :, :) = yuv(m, :, :);
    end
    m = numBlocksM * blockSize;
end
if(numBlocksN * blockSize ~= n)
    for j = n+1 : numBlocksN*blockSize
        yuv(:, j, :) = yuv(:, n, :);
    end
    n = numBlocksN * blockSize;
end

% 将图片分块
c1 = cell(numBlocksM, numBlocksN);
for i = 1:numBlocksM
    for j = 1:numBlocksN
        c1{i, j} = yuv(((i-1) * blockSize + 1):((i-1) * blockSize + blockSize), ((j-1) * blockSize + 1):((j-1) * blockSize + blockSize), 1);
    end
end

% 对每个宏块进行操作
resImage = zeros(m, n);
prediction = cell(1, 9);

% 定义存储预测重构块的变量
preFinal = cell(numBlocksM, numBlocksN);
preFinal{1, 1} = zeros(blockSize, blockSize);
% for i=1:blockSize
%     for j=1:blockSize
%         preFinal{1, 1}(:,:) = 127;
%     end
% end

QP = 10;
lenImage = 0;

for i = 1:numBlocksM
    for j = 1:numBlocksN
        % 帧内预测 9种预测模式
        prediction = intraPre(i, j, preFinal, blockSize, numBlocksN);
        
        transform = cell(1, 9);
        quantification = cell(1, 9);
        deQuantification = cell(1, 9);
        deTransform = cell(1, 9);
        dePrediction = cell(1, 9);
        dePSNR = zeros(1, 9);
        encoLen = zeros(1, 9);
        RD_rate = zeros(1, 9);
        for k = 1:9
            if prediction{k} ~= -1
                residual = double(c1{i, j}) - prediction{k};
                % DCT变换
                transform{k} = round(dct2(residual));
                
                % 量化
                quantification{k} = quantify(transform{k}, QP, 0);
                
                % Zigzag扫描
                z = zigzag(quantification{k}, 0);
                
                % 编码
                % RLE编码
                rle = encoRLE(z);
                % BIT编码
                bit = encoBIT(rle);
                % Huffman编码
                huf = huffman(bit);
                [~, encoLen(k)] = size(huf);
                
                % 反zigzag扫描
                deZ = zigzag(z, 1);

                % 反量化
                deQuantification{k} = quantify(deZ, QP, 1);
                
                % 反变换
                deTransform{k} = idct2(deQuantification{k});
                
                % 反预测
                dePrediction{k} = deIntraPre(blockSize, preFinal, i, j, k, numBlocksN) + deTransform{k};
                
                % RDO模式
                SSD = sum(sum((uint8(dePrediction{k})-c1{i, j}).^2));
                lamda = 0.85*2^((QP-12)/3);
                rate = 512/encoLen(k);
                RD_rate(k) = SSD + lamda * rate;
            end
        end
        
        % 为该宏块选出最优预测模式
        maxRD_rate = RD_rate(1);
        tmpK = 1;
        for k=2:9
            if RD_rate(k)>maxRD_rate
                maxRD_rate = RD_rate(k);
                tmpK = k;
            end
        end
        
        % 压缩图片大小
        lenImage = lenImage + encoLen(k);
        
        preFinal{i, j} = dePrediction{tmpK};
        resImage(((i-1) * blockSize + 1):((i-1) * blockSize + blockSize), ((j-1) * blockSize + 1):((j-1) * blockSize + blockSize)) = preFinal{i, j};
    end
end

% 按照原始大小切割图片
resImage = resImage(1:mOri, 1:nOri);
figure(3);
subplot(1, 2, 1); imshow(yOri(:,:,1)); title('original image');
subplot(1, 2, 2); imshow(uint8(resImage)); title('compressed image');
fprintf('psnr is %f, ssim is %f\n', psnr(yOri, uint8(resImage)), ssim(yOri, uint8(resImage)));
fprintf('the size of the reconstructed image is %d.\n', lenImage);
fprintf('the compression ratio is %f.\n', lenImage/(mOri*nOri*8));

% 生成JPEG图像
imwrite(yOri, 'bird_GT2.jpg', 'Quality', 1);
JPEG = imread('bird_GT2.jpg');
psnr_JPEG = psnr(yOri, JPEG); 