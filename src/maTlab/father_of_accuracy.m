function [me_vec, se_vec] = father_of_accuracy(vec)

accuvec = []; me_vec = []; se_vec = [];

for i = 1:length(vec)
        node = abs(vec(i));
        accuvec = [accuvec node];
        if length(accuvec) > 1
            me = me_old + (node-me_old)/length(accuvec);
            se_new = se_old + (node-me_old)*(node-me);
            se = sqrt(se_new/(length(accuvec)-1));
            me_old = me; se_old = se_new;
            me_vec = [me_vec me]; se_vec = [se_vec se];
        else
            se_old = 0; me_old = node; 
            me_vec = [me_vec me_old]; se_vec = [se_vec se_old];
        end        
end

end