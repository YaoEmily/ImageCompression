function [result] = intraPreDiagonalDownLeft(blockSize, preBlock1, preBlock2)
    result = zeros(blockSize, blockSize);
    for i = 1:blockSize
        for j = 1:blockSize
            if(i+j == 2)
                result(i, j) = (round(preBlock1(blockSize, 1) + preBlock1(blockSize, 2)*2 + preBlock1(blockSize, 3))) / 4;
            elseif(i+j == 3)
                result(i, j) = (round(preBlock1(blockSize, 2) + preBlock1(blockSize, 3)*2 + preBlock1(blockSize, 4))) / 4;
            elseif(i+j == 4)
                result(i, j) = (round(preBlock1(blockSize, 3) + preBlock1(blockSize, 4)*2 + preBlock1(blockSize, 5))) / 4;
            elseif(i+j == 5)
                result(i, j) = (round(preBlock1(blockSize, 4) + preBlock1(blockSize, 5)*2 + preBlock1(blockSize, 6))) / 4;
            elseif(i+j == 6)
                result(i, j) = (round(preBlock1(blockSize, 5) + preBlock1(blockSize, 6)*2 + preBlock1(blockSize, 7))) / 4;
            elseif(i+j == 7)
                result(i, j) = (round(preBlock1(blockSize, 6) + preBlock1(blockSize, 7)*2 + preBlock1(blockSize, 8))) / 4;
            elseif(i+j == 8)
                result(i, j) = (round(preBlock1(blockSize, 7) + preBlock1(blockSize, 8)*2 + preBlock2(blockSize, 1))) / 4;
            elseif(i+j == 9)
                result(i, j) = (round(preBlock1(blockSize, 8) + preBlock2(blockSize, 1)*2 + preBlock2(blockSize, 2))) / 4;
            elseif(i+j == 10)
                result(i, j) = (round(preBlock2(blockSize, 1) + preBlock2(blockSize, 2)*2 + preBlock2(blockSize, 3))) / 4;    
            elseif(i+j == 11)
                result(i, j) = (round(preBlock2(blockSize, 2) + preBlock2(blockSize, 3)*2 + preBlock2(blockSize, 4))) / 4;
            elseif(i+j == 12)
                result(i, j) = (round(preBlock2(blockSize, 3) + preBlock2(blockSize, 4)*2 + preBlock2(blockSize, 5))) / 4;
            elseif(i+j == 13)
                result(i, j) = (round(preBlock2(blockSize, 4) + preBlock2(blockSize, 5)*2 + preBlock2(blockSize, 6))) / 4;
            elseif(i+j == 14)
                result(i, j) = (round(preBlock2(blockSize, 5) + preBlock2(blockSize, 6)*2 + preBlock2(blockSize, 7))) / 4;
            elseif(i+j == 15)
                result(i, j) = (round(preBlock2(blockSize, 6) + preBlock2(blockSize, 7)*2 + preBlock2(blockSize, 8))) / 4;
            elseif(i+j == 16)
                result(i, j) = (round(preBlock2(blockSize, 7) + preBlock2(blockSize, 8)*3)) / 4;
            end
        end
    end
end