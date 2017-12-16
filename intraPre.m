function [prediction] = intraPre(i, j, c1, blockSize, numBlocksN)
    prediction = cell(1, 9);
    
    for k = 1:9
        prediction{k} = -1;
    end
    if i==1 || j==1
        % 只有 2:DC
        prediction{3} = intraPreDC(c1{i, j}, blockSize);
    elseif i==1
        % 只有 1:horizontal, 2:DC, 8:horizontal-up
        prediction{2} = intraPreHorizontal(blockSize, c1{i-1, j});
        prediction{3} = intraPreDC(c1{i, j}, blockSize);
        prediction{9} = intraPreHorizontalUp(blockSize, c1{i, j-1});
    elseif j==1
        % 只有 0:vertical, 2:DC, 7:vertical-left
        prediction{1} = intraPreVertical(blockSize, c1{i, j-1});
        prediction{3} = intraPreDC(c1{i, j}, blockSize);
        prediction{8} = intraPreVerticalLeft(blockSize, c1{i-1, j}, c1{i-1, j+1}, c1{i, j-1});
    elseif j==numBlocksN
        % 除了 3:diagnal down-left and 7:vertical-left
        prediction{1} = intraPreVertical(blockSize, c1{i, j-1});
        prediction{2} = intraPreHorizontal(blockSize, c1{i-1, j});
        prediction{3} = intraPreDC(c1{i, j}, blockSize);
        prediction{5} = intraPreDiagonalDownRight(blockSize, c1{i-1, j-1}, c1{i-1, j}, c1{i, j-1});
        prediction{6} = intraPreVerticalRight(blockSize, c1{i-1, j-1}, c1{i-1, j}, c1{i, j-1});
        prediction{7} = intraPreHorizontalDown(blockSize, c1{i-1, j-1}, c1{i-1, j}, c1{i, j-1});
        prediction{9} = intraPreHorizontalUp(blockSize, c1{i, j-1});
    else 
        % 所有预测模式
        prediction{1} = intraPreVertical(blockSize, c1{i, j-1});
        prediction{2} = intraPreHorizontal(blockSize, c1{i-1, j});
        prediction{3} = intraPreDC(c1{i, j}, blockSize);
        prediction{4} = intraPreDiagonalDownLeft(blockSize, c1{i-1, j}, c1{i-1, j+1});
        prediction{5} = intraPreDiagonalDownRight(blockSize, c1{i-1, j-1}, c1{i-1, j}, c1{i, j-1});
        prediction{6} = intraPreVerticalRight(blockSize, c1{i-1, j-1}, c1{i-1, j}, c1{i, j-1});
        prediction{7} = intraPreHorizontalDown(blockSize, c1{i-1, j-1}, c1{i-1, j}, c1{i, j-1});
        prediction{8} = intraPreVerticalLeft(blockSize, c1{i-1, j}, c1{i-1, j+1});
        prediction{9} = intraPreHorizontalUp(blockSize, c1{i, j-1});
    end
end