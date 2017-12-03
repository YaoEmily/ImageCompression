clear;

% Read image
arr = imread('bird_GT.bmp');
arr = rgb2gray(arr);
figure(1);
imshow(arr);

% Divide image into blockSize*blockSize pixel blocks
blockSize = 4;
[m, n] = size(arr);
numBlocksM = ceil(m / blockSize);
numBlocksN = ceil(n / blockSize);
c1 = cell(numBlocksM, numBlocksN);
resArr = arr;
for i = 1:numBlocksM
    for j = 1:numBlocksN
        c1{i, j} = arr(((i-1) * blockSize + 1):((i-1) * blockSize + blockSize), ((j-1) * blockSize + 1):((j-1) * blockSize + blockSize));
    end
end

% Predictive coding
for i = 1:numBlocksM
    for j = 1:numBlocksN
        result0 = -1; result1 = -1; result2 = -1; result3 = -1; result4 = -1; result5 = -1; result6 = -1; result7 = -1; result8 = -1;
        if i==1 || j==1
            % only 2:DC
            result2 = intraPreDC(c1{i, j}, blockSize);
        elseif i==1
            % only 1:horizontal, 2:DC, 8:horizontal-up
            result1 = intraPreHorizontal(blockSize, c1{i-1, j});
            result2 = intraPreDC(c1{i, j}, blockSize);
            result8 = intraPreHorizontalUp(blockSize, c1{i, j-1});
        elseif j==1
            % only 0:vertical, 2:DC, 7:vertical-left
            result0 = intraPreVertical(blockSize, c1{i, j-1});
            result2 = intraPreDC(c1{i, j}, blockSize);
            result7 = intraPreVerticalLeft(blockSize, c1{i-1, j}, c1{i-1, j+1}, c1{i, j-1});
        elseif j==numBlocksN
            % without 3:diagnal down-left and 7:vertical-left
            result0 = intraPreVertical(blockSize, c1{i, j-1});
            result1 = intraPreHorizontal(blockSize, c1{i-1, j});
            result2 = intraPreDC(c1{i, j}, blockSize);
            result4 = intraPreDiagonalDownRight(blockSize, c1{i-1, j-1}, c1{i-1, j}, c1{i, j-1});
            result5 = intraPreVerticalRight(blockSize, c1{i-1, j-1}, c1{i-1, j}, c1{i, j-1});
            result6 = intraPreHorizontalDown(blockSize, c1{i-1, j-1}, c2{i-1, j}, c1{i, j-1});
            result8 = intraPreHorizontalUp(blockSize, c1{i, j-1});
        else 
            % all prediction modes
            result0 = intraPreVertical(blockSize, c1{i, j-1});
            result1 = intraPreHorizontal(blockSize, c1{i-1, j});
            result2 = intraPreDC(c1{i, j}, blockSize);
            result3 = intraPreDiagonalDownLeft(blockSize, c1{i-1, j}, c1{i-1, j+1});
            result4 = intraPreDiagonalDownRight(blockSize, c1{i-1, j-1}, c1{i-1, j}, c1{i, j-1});
            result5 = intraPreVerticalRight(blockSize, c1{i-1, j-1}, c1{i-1, j}, c1{i, j-1});
            result6 = intraPreHorizontalDown(blockSize, c1{i-1, j-1}, c2{i-1, j}, c1{i, j-1});
            result7 = intraPreVerticalLeft(blockSize, c1{i-1, j}, c1{i-1, j+1}, c1{i, j-1});
            result8 = intraPreHorizontalUp(blockSize, c1{i, j-1});
        end
        resArr(((i-1) * blockSize + 1):((i-1) * blockSize + blockSize), ((j-1) * blockSize + 1):((j-1) * blockSize + blockSize)) = result2;
    end
end

figure(2);
imshow(resArr);
fprintf('psnr is %f, ssim is %f', psnr(arr, resArr), ssim(arr, resArr));


% DCT
