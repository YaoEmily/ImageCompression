function [result] = intraPreDC(currentBlock, blockSize)
    result = zeros(blockSize, blockSize);
    for i = 1:blockSize
        for j = 1:blockSize
            result(i, j) = mean(currentBlock(:));
        end
    end
end