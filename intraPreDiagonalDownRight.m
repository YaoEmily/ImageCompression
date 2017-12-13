function [result] = intraPreDiagonalDownRight(blockSize, preBlock1, preBlock2, preBlock3)
    result = zeros(blockSize, blockSize);
    for i = 1:blockSize
        for j = 1:blockSize
            if i-j == -7
                result(i, j) = round(preBlock2(8, 6) + preBlock2(8, 7)*2 + preBlock2(8, 8)) / 4;
            elseif i-j == -6
                result(i, j) = round(preBlock2(8, 5) + preBlock2(8, 6)*2 + preBlock2(8, 7)) / 4;
            elseif i-j == -5
                result(i, j) = round(preBlock2(8, 4) + preBlock2(8, 5)*2 + preBlock2(8, 6)) / 4;
            elseif i-j == -4
                result(i, j) = round(preBlock2(8, 3) + preBlock2(8, 4)*2 + preBlock2(8, 5)) / 4;
            elseif i-j == -3
                result(i, j) = round(preBlock2(8, 2) + preBlock2(8, 3)*2 + preBlock2(8, 4)) / 4;
            elseif i-j == -2
                result(i, j) = round(preBlock2(8, 1) + preBlock2(8, 2)*2 + preBlock2(8, 3)) / 4;
            elseif i-j == -1
                result(i, j) = round(preBlock1(8, 8) + preBlock2(8, 1)*2 + preBlock2(8, 2)) / 4;
            elseif i-j == 0
                result(i, j) = round(preBlock3(1, 8) + preBlock1(8, 8)*2 + preBlock2(8, 1)) / 4;
            elseif i-j == 1
                result(i, j) = round(preBlock3(2, 8) + preBlock3(1, 8)*2 + preBlock1(8, 8)) / 4;
            elseif i-j == 2
                result(i, j) = round(preBlock3(3, 8) + preBlock3(2, 8)*2 + preBlock3(1, 8)) / 4;
            elseif i-j == 3
                result(i, j) = round(preBlock3(4, 8) + preBlock3(3, 8)*2 + preBlock3(2, 8)) / 4;
            elseif i-j == 4
                result(i, j) = round(preBlock3(5, 8) + preBlock3(4, 8)*2 + preBlock3(3, 8)) / 4;
            elseif i-j == 5
                result(i, j) = round(preBlock3(6, 8) + preBlock3(5, 8)*2 + preBlock3(4, 8)) / 4;
            elseif i-j == 6
                result(i, j) = round(preBlock3(7, 8) + preBlock3(6, 8)*2 + preBlock3(5, 8)) / 4;
            elseif i-j == 7
                result(i, j) = round(preBlock3(8, 8) + preBlock3(7, 8)*2 + preBlock3(6, 8)) / 4;
            end
        end
    end
end