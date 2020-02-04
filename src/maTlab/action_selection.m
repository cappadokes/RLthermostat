%========================================================================
%|National Technical University of Athens                               |
%|School of Electrical & Computer Engineering                           |
%|Microprocessors & Digital Systems Lab                                 |
%|----------------------------------------------------------------------|
%|"Realization of an Energy Management System for Commercial Buildings" |
%|Undergraduate Thesis                                                  |
%========================================================================

function [min_val, idx, probz] = action_selection(state, pos_acts, old_net, T)

exp_values = zeros(size(pos_acts,1),size(state,2));
probz = exp_values;

for i = 1:size(pos_acts,1)
     input = [state; pos_acts(i,:)];
     val = sim(old_net, input);
     exp_values(i,:) = exp(val/T);
end

sum_exp = sum(exp_values);

for j = 1:size(state,2)
    probz(:,j) = exp_values(:,j)./sum_exp(j);
end

[min_val, idx] = min(probz);

end