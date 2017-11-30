function [result] = intraPreHorizontal(blockSize, preBlock)
    result = zeros(blockSize, blockSize);
    for i = 1:blockSize
        for j = 1:blockSize
            result(i, j) = preBlock(i, blockSize);
        end
    end
end