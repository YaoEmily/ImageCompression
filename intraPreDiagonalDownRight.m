function [result] = intraPreDiagonalDownRight(blockSize, preBlock1, preBlock2, preBlock3)
    result = zeros(blockSize, blockSize);
    for i = 1:blockSize
        for j = 1:blockSize
            if(i-j == -3)
                result(i, j) = (round(preBlock2(4, 2) + preBlock2(4, 3)*2 + preBlock2(4, 4))) / 4;
            elseif (i-j == -2)
                result(i, j) = (round(preBlock2(4, 1) + preBlock2(4, 2)*2 + preBlock2(4, 3))) / 4;
            elseif(i-j == -1)
                result(i, j) = (round(preBlock1(4, 4) + preBlock2(4, 1)*2 + preBlock2(4, 2))) / 4;
            elseif(i-j == 0)
                result(i, j) = (round(preBlock3(1, 4) + preBlock1(4, 4)*2 + preBlock2(4, 1))) / 4;
            elseif(i-j == 1)
                result(i, j) = (round(preBlock3(2, 4) + preBlock3(1, 4)*2 + preBlock1(4, 4))) / 4;
            elseif(i-j == 2)
                result(i, j) = (round(preBlock3(3, 4) + preBlock3(2, 4)*2 + preBlock3(1, 4))) / 4;
            elseif(i-j == 3)
                result(i, j) = (round(preBlock3(4, 4) + preBlock3(3, 4)*2 + preBlock3(2, 4))) / 4;
            end
        end
    end
end