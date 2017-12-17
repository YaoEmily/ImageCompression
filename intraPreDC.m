function [result] = intraPreDC(blockSize, preBlock1, preBlock2)
    result = zeros(blockSize, blockSize);
    mu = (sum(preBlock1(8, :)) + sum(preBlock2(:, 8)))/16;
    result(:, :) = round(mu);
end