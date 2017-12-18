function [result] = zigzag(matrix, flag)
    load('zigzagTable.mat');
    if flag==0
        [m, n] = size(matrix);
        if m == n && m == 8
            result = zeros(1, m*m);
            for i=1:m
                for j=1:n
                    result(zigzagTable(i, j)+1) = matrix(i, j);
                end
            end
%             result = zeros(1, m*m);
%             ori = 1;
%             for k = 2:2*m
%                 if k <= m && mod(k, 2) == 0
%                     for l = 1:k-1
%                         j = l;
%                         i = k - j;
%                         result(ori) = matrix(i, j);
%                         ori = ori + 1;
%                     end
%                 elseif k <= m && mod(k, 2) == 1
%                     for l = 1:k-1
%                         i = l;
%                         j = k - i;
%                         result(ori) = matrix(i, j);
%                         ori = ori + 1;
%                     end
%                 elseif mod(k, 2) == 0
%                     for l = 8:-1:k-8
%                         i = l;
%                         j = k - i;
%                         result(ori) = matrix(i, j);
%                         ori = ori + 1;
%                     end
%                 elseif mod(k, 2) == 1
%                     for l = 8:-1:k-8
%                         j = l;
%                         i = k - j;
%                         result(ori) = matrix(i, j);
%                         ori = ori + 1;
%                     end
%                 end
%             end
        else
            fprintf('Their is something wrong1.\n');
        end
    elseif flag == 1
        [~, n] = size(matrix);
        if n == 64
        result = zeros(8, 8);
        for i = 1:8
            for j = 1:8
                result(i, j) = matrix(zigzagTable(i, j)+1);
            end
        end
        else
            fprintf('Their is something wrong2.\n');
        end
    else
        fprintf('Their is something wrong3.\n');
    end
end