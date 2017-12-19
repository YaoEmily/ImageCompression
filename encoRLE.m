function [result] = encoRLE(z)
    [~, len] = size(z);
    sum = 1;
    num_zeros = 0;
    % ��Z��ɨ�������ݽ��з���
    for i=1:len
        if z(i)==0 && num_zeros<16
            num_zeros = num_zeros + 1;
        elseif z(i)==0 && num_zeros==16
            result(sum, 1) = 15;
            result(sum, 2) = 0;
            sum = sum + 1;
            num_zeros = 0;
        else
            result(sum, 1) = num_zeros;
            result(sum, 2) = z(i);
            sum = sum + 1;
            num_zeros = 0;
        end
    end
    
    % ��RLEβ��ȫ0ȥ��
    [m, ~] = size(result);
    for i=m:-1:1
        if result(i, 2)~=0
            tmp = i;
            break;
        end
    end
    result = result(1:tmp, :);
end