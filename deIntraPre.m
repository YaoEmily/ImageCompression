function [result] = deIntraPre(blockSize, preFinal, i, j, mode, numBlocksN)
    % ¾ùÔÈ¿é
    evenBlock = zeros(8,8);
    evenBlock(:,:) = 127;
    
    if mode == 1
        if i==1
            result = intraPreVertical(blockSize, evenBlock);
        else
            result = intraPreVertical(blockSize, preFinal{i-1, j});
        end
    elseif mode == 2
        if j==1
            result = intraPreHorizontal(blockSize, evenBlock);
        else
            result = intraPreHorizontal(blockSize, preFinal{i, j-1});
        end
    elseif mode == 3
        if i==1 && j==1
            result = intraPreDC(blockSize, evenBlock, evenBlock);
        elseif i==1
            result = intraPreDC(blockSize, evenBlock, preFinal{i, j-1});
        elseif j==1
            result = intraPreDC(blockSize, preFinal{i-1, j}, evenBlock);
        else
            result = intraPreDC(blockSize, preFinal{i-1, j}, preFinal{i, j-1});
        end
    elseif mode == 4
        if i==1
            result = intraPreDiagonalDownLeft(blockSize, evenBlock, evenBlock);
        elseif j==numBlocksN
            result = intraPreDiagonalDownLeft(blockSize, preFinal{i-1, j}, evenBlock);
        else
            result = intraPreDiagonalDownLeft(blockSize, preFinal{i-1, j}, preFinal{i-1, j+1});
        end
    elseif mode == 5
        if i==1 && j==1
            result = intraPreDiagonalDownRight(blockSize, evenBlock, evenBlock, evenBlock);
        elseif i==1
            result = intraPreDiagonalDownRight(blockSize, evenBlock, evenBlock, preFinal{i, j-1});
        elseif j==1
            result = intraPreDiagonalDownRight(blockSize, evenBlock, preFinal{i-1, j}, evenBlock);
        else
            result = intraPreDiagonalDownRight(blockSize, preFinal{i-1, j-1}, preFinal{i-1, j}, preFinal{i, j-1});
        end
    elseif mode == 6
        if i==1 && j==1
            result = intraPreVerticalRight(blockSize, evenBlock, evenBlock, evenBlock);
        elseif i==1
            result = intraPreVerticalRight(blockSize, evenBlock, evenBlock, preFinal{i, j-1});
        elseif j==1
            result = intraPreVerticalRight(blockSize, evenBlock, preFinal{i-1, j}, evenBlock);
        else
            result = intraPreVerticalRight(blockSize, preFinal{i-1, j-1}, preFinal{i-1, j}, preFinal{i, j-1});
        end
    elseif mode == 7
        if i==1 && j==1
            result = intraPreHorizontalDown(blockSize, evenBlock, evenBlock, evenBlock);
        elseif i==1
            result = intraPreHorizontalDown(blockSize, evenBlock, evenBlock, preFinal{i, j-1});
        elseif j==1
            result = intraPreHorizontalDown(blockSize, evenBlock, preFinal{i-1, j}, evenBlock);
        else
            result = intraPreHorizontalDown(blockSize, preFinal{i-1, j-1}, preFinal{i-1, j}, preFinal{i, j-1});
        end
    elseif mode == 8
        if i==1
            result = intraPreVerticalLeft(blockSize, evenBlock, evenBlock);
        elseif j==numBlocksN
            result = intraPreVerticalLeft(blockSize, preFinal{i-1, j}, evenBlock);
        else
            result = intraPreVerticalLeft(blockSize, preFinal{i-1, j}, preFinal{i-1, j+1});
        end
    elseif mode == 9
        if j==1
            result = intraPreHorizontalUp(blockSize, evenBlock);
        else
            result = intraPreHorizontalUp(blockSize, preFinal{i, j-1});
        end
    end
end