function [result] = encoBIT(rle)
    [m, ~] = size(rle);
    result = cell(m, 3);
    for i = 1:m
        if rle(i, 2)==0
            group = 0;
            bits = '';
        elseif rle(i, 2)==-1 || rle(i, 2) ==1
            group = 1;
            if rle(i, 2)==-1
                bits = '0';
            else
                bits = '1';
            end
        elseif rle(i, 2)==-3 || rle(i, 2)==-2 || rle(i, 2)==2 || rle(i, 2)==3
            group = 2;
            if rle(i, 2)<0
                bits = ['0', completeBits(dec2bin(3-abs(rle(i, 2))), group)];
            else
                bits = ['1', completeBits(dec2bin(abs(2-rle(i, 2))), group)];
            end
        elseif (rle(i, 2)>=-7 && rle(i, 2)<=-4) || (rle(i, 2)>=4 && rle(i, 2)<=7)
            group = 3;
            if rle(i, 2)<0
                bits = ['0', completeBits(dec2bin(7-abs(rle(i, 2))), group)];
            else
                bits = ['1', completeBits(dec2bin(abs(4-rle(i, 2))), group)];
            end
        elseif (rle(i, 2)>=-15 && rle(i, 2)<=-8) || (rle(i, 2)>=8 && rle(i, 2)<=15)
            group = 4;
            if rle(i, 2)<0
                bits = ['0', completeBits(dec2bin(15-abs(rle(i, 2))), group)];
            else
                bits = ['1', completeBits(dec2bin(abs(8-rle(i, 2))), group)];
            end
        elseif (rle(i, 2)>=-31 && rle(i, 2)<=-16) || (rle(i, 2)>=16 && rle(i, 2)<=31)
            group = 5;
            if rle(i, 2)<0
                bits = ['0', completeBits(dec2bin(31-abs(rle(i, 2))), group)];
            else
                bits = ['1', completeBits(dec2bin(abs(16-rle(i, 2))), group)];
            end
        elseif (rle(i, 2)>=-63 && rle(i, 2)<=-32) || (rle(i, 2)>=32 && rle(i, 2)<=63)
            group = 6;
            if rle(i, 2)<0
                bits = ['0', completeBits(dec2bin(63-abs(rle(i, 2))), group)];
            else
                bits = ['1', completeBits(dec2bin(abs(32-rle(i, 2))), group)];
            end
        elseif (rle(i, 2)>=-127 && rle(i, 2)<=-64) || (rle(i, 2)>=64 && rle(i, 2)<=127)
            group = 7;
            if rle(i, 2)<0
                bits = ['0', completeBits(dec2bin(127-abs(rle(i, 2))), group)];
            else
                bits = ['1', completeBits(dec2bin(abs(64-rle(i, 2))), group)];
            end
        elseif (rle(i, 2)>=-255 && rle(i, 2)<=-128) || (rle(i, 2)>=128 && rle(i, 2)<=255)
            group = 8;
            if rle(i, 2)<0
                bits = ['0', completeBits(dec2bin(255-abs(rle(i, 2))), group)];
            else
                bits = ['1', completeBits(dec2bin(abs(128-rle(i, 2))), group)];
            end
        elseif (rle(i, 2)>=-511 && rle(i, 2)<=-256) || (rle(i, 2)>=256 && rle(i, 2)<=511)
            group = 9;
            if rle(i, 2)<0
                bits = ['0', completeBits(dec2bin(511-abs(rle(i, 2))), group)];
            else
                bits = ['1', completeBits(dec2bin(abs(256-rle(i, 2))), group)];
            end
        elseif (rle(i, 2)>=-1023 && rle(i, 2)<=-512) || (rle(i, 2)>=512 && rle(i, 2)<=1023)
            group = 10;
            if rle(i, 2)<0
                bits = ['0', completeBits(dec2bin(1023-abs(rle(i, 2))), group)];
            else
                bits = ['1', completeBits(dec2bin(abs(512-rle(i, 2))), group)];
            end
        elseif (rle(i, 2)>=-2047 && rle(i, 2)<=-1024) || (rle(i, 2)>=1024 && rle(i, 2)<=2047)
            group = 11;
            if rle(i, 2)<0
                bits = ['0', completeBits(dec2bin(2047-abs(rle(i, 2))), group)];
            else
                bits = ['1', completeBits(dec2bin(abs(1024-rle(i, 2))), group)];
            end
        end
        result{i, 1} = rle(i, 1);
        result{i, 2} = group;
        result{i, 3} = bits;
    end
end