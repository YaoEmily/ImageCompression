clear;

% ��ȡͼƬ
rgb = imread('bird_GT2.bmp');
% figure(1);
% imshow(rgb);

% ��ͼƬ��rgbת��Ϊyuv
yuv = rgb2ycbcr(rgb);
yOri = yuv(:,:,1);

% ��ȫͼƬ����Ϊ8�ı���
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

% ��ͼƬ�ֿ�
c1 = cell(numBlocksM, numBlocksN);
for i = 1:numBlocksM
    for j = 1:numBlocksN
        c1{i, j} = yuv(((i-1) * blockSize + 1):((i-1) * blockSize + blockSize), ((j-1) * blockSize + 1):((j-1) * blockSize + blockSize), 1);
    end
end

% ��ÿ�������в���
resImage = zeros(m, n);
prediction = cell(1, 9);

% ����洢Ԥ���ع���ı���
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
        % ֡��Ԥ�� 9��Ԥ��ģʽ
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
                % DCT�任
                transform{k} = round(dct2(residual));
                
                % ����
                quantification{k} = quantify(transform{k}, QP, 0);
                
                % Zigzagɨ��
                z = zigzag(quantification{k}, 0);
                
                % ����
                % RLE����
                rle = encoRLE(z);
                % BIT����
                bit = encoBIT(rle);
                % Huffman����
                huf = huffman(bit);
                [~, encoLen(k)] = size(huf);
                
                % ��zigzagɨ��
                deZ = zigzag(z, 1);

                % ������
                deQuantification{k} = quantify(deZ, QP, 1);
                
                % ���任
                deTransform{k} = idct2(deQuantification{k});
                
                % ��Ԥ��
                dePrediction{k} = deIntraPre(blockSize, preFinal, i, j, k, numBlocksN) + deTransform{k};
                
                % RDOģʽ
                SSD = sum(sum((uint8(dePrediction{k})-c1{i, j}).^2));
                lamda = 0.85*2^((QP-12)/3);
                rate = 512/encoLen(k);
                RD_rate(k) = SSD + lamda * rate;
            end
        end
        
        % Ϊ�ú��ѡ������Ԥ��ģʽ
        maxRD_rate = RD_rate(1);
        tmpK = 1;
        for k=2:9
            if RD_rate(k)>maxRD_rate
                maxRD_rate = RD_rate(k);
                tmpK = k;
            end
        end
        
        % ѹ��ͼƬ��С
        lenImage = lenImage + encoLen(k);
        
        preFinal{i, j} = dePrediction{tmpK};
        resImage(((i-1) * blockSize + 1):((i-1) * blockSize + blockSize), ((j-1) * blockSize + 1):((j-1) * blockSize + blockSize)) = preFinal{i, j};
    end
end

% ����ԭʼ��С�и�ͼƬ
resImage = resImage(1:mOri, 1:nOri);
figure(3);
subplot(1, 2, 1); imshow(yOri(:,:,1)); title('original image');
subplot(1, 2, 2); imshow(uint8(resImage)); title('compressed image');
fprintf('psnr is %f, ssim is %f\n', psnr(yOri, uint8(resImage)), ssim(yOri, uint8(resImage)));
fprintf('the size of the reconstructed image is %d.\n', ceil(lenImage/8));
fprintf('the compression ratio is %f.\n', (mOri*nOri*8)/lenImage);