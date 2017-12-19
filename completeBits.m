function [result] = completeBits(bits, num)
    [~, len] = size(bits);
    tmp = '';
    for i=1:num-1-len
        tmp = [tmp, '0'];
    end
    result = [tmp, bits];
end