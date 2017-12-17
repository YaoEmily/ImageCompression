function [result] = quantify(zig, flag)
    load('quanTable.mat');
    if flag==0
        result = round(zig ./ quanTable);
    else
        result = zig .* quanTable;
    end
end