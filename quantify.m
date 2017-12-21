function [result] = quantify(trans, QP, flag)
    load('Qstep.mat');
    if QP>=0 && QP<=51
        step = Qstep(QP+1, 2);
        if flag==0
            result = round(trans ./ step);
        else
            result = trans .* step;
        end
    else
        fprintf('QP is out of range.\n');
    end
end