function result = intraPreVertical(currentBlock, blockSize, preBlock)
    result = zeros(blockSize, blockSize);
    for i = 1:blockSize
        for j = 1:blockSize
            result(i, j) = preBlock(blockSize, j);
        end
    end
end