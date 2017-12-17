function [resultDC, resultAC] = huffman(zig1, zig2, flag)
    [~, len1] = size(zig1);
    [~, len2] = size(zig2);
    load('huffmanDictDC.mat');
    load('huffmanDictAC.mat');
    if flag == 0
        resultDC = huffmanenco(zig1(1:len1/4), DCdict);
        resultAC = huffmanenco(zig1(len1/4+1:len1), ACdict);
    else
        resultDC = huffmandeco(zig1, DCdict);
        resultAC = huffmandeco(zig2, ACdict);
    end
end