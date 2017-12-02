function [result] = intraPreDiagonalDownLeft(blockSize, preBlock1, preBlock2)
    result = zeros(blockSize, blockSize);
    for i = 1:blockSize
        for j = 1:blockSize
            if(i+j == 2)
                result(i, j) = (round(preBlock1(blockSize, 1) + preBlock1(blockSize, 2)*2 + preBlock1(blockSize, 3))) / 4;
            elseif (i+j == 3)
                result(i, j) = (round(preBlock1(blockSize, 2) + preBlock1(blockSize, 3)*2 + preBlock1(blockSize, 4))) / 4;
            elseif(i+j == 4)
                result(i, j) = (round(preBlock1(blockSize, 3) + preBlock1(blockSize, 4)*2 + preBlock2(blockSize, 1))) / 4;
            elseif(i+j == 5)
                result(i, j) = (round(preBlock1(blockSize, 4) + preBlock2(blockSize, 1)*2 + preBlock2(blockSize, 2))) / 4;
            elseif(i+j == 4)
                result(i, j) = (round(preBlock2(blockSize, 1) + preBlock2(blockSize, 2)*2 + preBlock2(blockSize, 3))) / 4;
            elseif(i+j == 4)
                result(i, j) = (round(preBlock2(blockSize, 2) + preBlock2(blockSize, 3)*2 + preBlock2(blockSize, 4))) / 4;
            elseif(i+j == 4)
                result(i, j) = (round(preBlock2(blockSize, 3) + preBlock2(blockSize, 4)*3)) / 4;
            end
        end
    end
end