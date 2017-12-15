function [result] = zigzag(matrix)
    [m, n] = size(matrix);
    if m == n
        result = zeros(1, m*m);
        ori = 1;
        for k = 2:2*m
            if k <= m && mod(k, 2) == 0
                for l = 1:k-1
                    j = l;
                    i = k - j;
                    result(ori) = matrix(i, j);
                    ori = ori + 1;
                end
            elseif k <= m && mod(k, 2) == 1
                for l = 1:k-1
                    i = l;
                    j = k - i;
                    result(ori) = matrix(i, j);
                    ori = ori + 1;
                end
            elseif mod(k, 2) == 0
                for l = 8:-1:k-8
                    i = l;
                    j = k - i;
                    result(ori) = matrix(i, j);
                    ori = ori + 1;
                end
            elseif mod(k, 2) == 1
                for l = 8:-1:k-8
                    j = l;
                    i = k - j;
                    result(ori) = matrix(i, j);
                    ori = ori + 1;
                end
            end
        end
    else
        fprintf('Their is something wrong.\n');
    end
end