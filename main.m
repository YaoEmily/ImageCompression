clear;

% 读取图片
rgb = imread('bird_GT2.bmp');
% figure(1);
% imshow(rgb);

% 补全图片长宽为8的倍数
blockSize = 8;
[m, n, k] = size(rgb);
mOri = m;
nOri = n;
numBlocksM = ceil(m / blockSize);
numBlocksN = ceil(n / blockSize);
if(numBlocksM * blockSize ~= m)
    for i = m+1 : numBlocksM*blockSize
        rgb(i, :, :) = rgb(m, :, :);
    end
    m = numBlocksM * blockSize;
end
if(numBlocksN * blockSize ~= n)
    for j = n+1 : numBlocksN*blockSize
        rgb(:, j, :) = rgb(:, n, :);
    end
    n = numBlocksN * blockSize;
end

% 将图片由rgb转换为yuv
yuv = rgb2ycbcr(rgb);
% figure(2);
% imshow(yuv(:,:,1));

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
        for k = 1:9
            if prediction{k} ~= -1
                residual = double(c1{i, j}) - prediction{k};
                % DCT变换
                transform{k} = round(dct2(residual));
                
                % 量化
                quantification{k} = quantify(transform{k}, 0);
                
%                 % Zigzag扫描
%                 z = zigzag(quantification{k}, 0);
%                 
%                 % 编码 哈夫曼编码
%                 if i==1 && j==1
%                     getHuffmanTable(z);
%                 end
%                 [encoDC, encoAC] = huffman(z, 0, 0);
%                 
%                 % 解码
%                 %deco = huffman(encoDC, encoAC, 1);
%                 [~,len1] = size(encoDC);
%                 [~,len2] = size(encoAC);
%                 
%                 % 反zigzag扫描

                % 反量化
                deQuantification{k} = quantify(quantification{k}, 1);
                
                % 反变换
                deTransform{k} = idct2(deQuantification{k});
                
                % 反预测
                dePrediction{k} = deIntraPre(blockSize, preFinal, i, j, k, numBlocksN) + deTransform{k};
                dePSNR(k) = psnr(uint8(dePrediction{k}), c1{i, j});
%                 fprintf('psnr = %f\n', dePSNR(k));
%                 figure(1);
%                 imshow(uint8(dePrediction{k}));
%                 figure(2);
%                 imshow(c1{i, j});
            end
        end
        
        % 为该宏块选出最优预测模式
        maxPSNR = dePSNR(1);
        tmpK = 1;
        for k=2:9
            if dePSNR(k)>maxPSNR
                maxPSNR = dePSNR(k);
                tmpK = k;
            end
        end
        
        preFinal{i, j} = dePrediction{tmpK};
        resImage(((i-1) * blockSize + 1):((i-1) * blockSize + blockSize), ((j-1) * blockSize + 1):((j-1) * blockSize + blockSize)) = preFinal{i, j};
    end
end

% 按照原始大小切割图片
resImage = resImage(1:mOri, 1:nOri);
figure(3);
subplot(1, 2, 1); imshow(yuv(:,:,1)); title('original image');
subplot(1, 2, 2); imshow(uint8(resImage)); title('compressed image');
fprintf('psnr is %f, ssim is %f\n', psnr(yuv(:,:,1), uint8(resImage)), ssim(yuv(:,:,1), uint8(resImage)));


% DCT
