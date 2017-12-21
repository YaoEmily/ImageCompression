function [result] = huffman(bit)
    load('haffmanTable.mat');
    [m, ~] = size(bit);
    sum = 1;
    result = 0;
    for i=1:m
        tmp = bit{i, 1}*16 + bit{i, 2};
        huf = huffmanTable{tmp, 2};
        huf = huf(:, 3:6);
        huf = dec2bin(hex2dec(huf));
        huf = completeBits(huf, huffmanTable{tmp, 1});
        [~, len] = size(huf);
        for j=1:len
            result(sum) = huf(j)-48;
            sum = sum + 1;
        end
        
        [~, len] = size(bit{i, 3});
        for j=1:len
            result(sum) = bit{i, 3}(j)-48;
            sum = sum + 1;
        end
    end
    
    % Ìí¼ÓEOB
    result(sum) = 1;
    result(sum+1) = 0;
    result(sum+2) = 1;
    result(sum+3) = 0;
end