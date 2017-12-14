function [result] = intraPreVerticalLeft(blockSize, preBlock1, preBlock2)
    result = zeros(blockSize, blockSize);
    result(1, 1) = round(preBlock1(8, 1) + preBlock1(8, 2)) / 2;
    result(1, 2) = round(preBlock1(8, 2) + preBlock1(8, 3)) / 2;
    result(1, 3) = round(preBlock1(8, 3) + preBlock1(8, 4)) / 2;
    result(1, 4) = round(preBlock1(8, 4) + preBlock1(8, 5)) / 2;
    result(1, 4) = round(preBlock1(8, 5) + preBlock1(8, 6)) / 2;
    result(1, 4) = round(preBlock1(8, 6) + preBlock1(8, 7)) / 2;
    result(1, 4) = round(preBlock1(8, 7) + preBlock1(8, 8)) / 2;
    result(1, 4) = round(preBlock1(8, 8) + preBlock2(8, 1)) / 2;
    result(2, 1) = round(preBlock1(8, 1) + preBlock1(8, 2)*2 + preBlock1(8, 3)) / 4;
    result(2, 2) = round(preBlock1(8, 2) + preBlock1(8, 3)*2 + preBlock1(8, 4)) / 4;
    result(2, 3) = round(preBlock1(8, 3) + preBlock1(8, 4)*2 + preBlock1(8, 5)) / 4;
    result(2, 4) = round(preBlock1(8, 4) + preBlock1(8, 5)*2 + preBlock1(8, 6)) / 4;
    result(2, 5) = round(preBlock1(8, 5) + preBlock1(8, 6)*2 + preBlock1(8, 7)) / 4;
    result(2, 6) = round(preBlock1(8, 6) + preBlock1(8, 7)*2 + preBlock1(8, 8)) / 4;
    result(2, 7) = round(preBlock1(8, 7) + preBlock1(8, 8)*2 + preBlock2(8, 1)) / 4;
    result(2, 8) = round(preBlock1(8, 8) + preBlock2(8, 1)*2 + preBlock2(8, 2)) / 4;
    result(3, 1) = result(1, 2);
    result(3, 2) = result(1, 3);
    result(3, 3) = result(1, 4);
    result(3, 4) = result(1, 5);
    result(3, 5) = result(1, 6);
    result(3, 6) = result(1, 7);
    result(3, 7) = result(1, 8);
    result(3, 8) = round(preBlock2(8, 1) + preBlock2(8, 2)) / 2;
    result(4, 1) = result(2, 2);
    result(4, 2) = result(2, 3);
    result(4, 3) = result(2, 4);
    result(4, 4) = result(2, 5);
    result(4, 5) = result(2, 6);
    result(4, 6) = result(2, 7);
    result(4, 7) = result(2, 8);
    result(4, 8) = round(preBlock2(8, 1) + preBlock2(8, 2)*2 + preBlock2(8, 3)) / 4;
    result(5, 1) = result(3, 2);
    result(5, 2) = result(3, 3);
    result(5, 3) = result(3, 4);
    result(5, 4) = result(3, 5);
    result(5, 5) = result(3, 6);
    result(5, 6) = result(3, 7);
    result(5, 7) = result(3, 8);
    result(5, 8) = round(preBlock2(8, 2) + preBlock2(8, 3)) / 2;
    result(6, 1) = result(4, 2);
    result(6, 2) = result(4, 3);
    result(6, 3) = result(4, 4);
    result(6, 4) = result(4, 5);
    result(6, 5) = result(4, 6);
    result(6, 6) = result(4, 7);
    result(6, 7) = result(4, 8);
    result(6, 8) = round(preBlock2(8, 2) + preBlock2(8, 3)*2 + preBlock2(8, 4)) / 4;
    result(7, 1) = result(5, 2);
    result(7, 2) = result(5, 3);
    result(7, 3) = result(5, 4);
    result(7, 4) = result(5, 5);
    result(7, 5) = result(5, 6);
    result(7, 6) = result(5, 7);
    result(7, 7) = result(5, 8);
    result(7, 8) = round(preBlock2(8, 3) + preBlock2(8, 4)) / 2;
    result(8, 1) = result(6, 2);
    result(8, 2) = result(6, 3);
    result(8, 3) = result(6, 4);
    result(8, 4) = result(6, 5);
    result(8, 5) = result(6, 6);
    result(8, 6) = result(6, 7);
    result(8, 7) = result(6, 8);
    result(8, 8) = round(preBlock2(8, 3) + preBlock2(8, 4)*2 + preBlock2(8, 5)) / 4;
end