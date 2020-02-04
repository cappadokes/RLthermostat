%========================================================================
%|National Technical University of Athens                               |
%|School of Electrical & Computer Engineering                           |
%|Microprocessors & Digital Systems Lab                                 |
%|----------------------------------------------------------------------|
%|"Realization of an Energy Management System for Commercial Buildings" |
%|Undergraduate Thesis                                                  |
%========================================================================

function [min_val, idxs] = best_action_value_dual(state, pos_acts, net_en, net_fang, tradeoff)

input = [state; pos_acts(1,:)];
output(1,:) = tradeoff*sim(net_en, input)+(1-tradeoff)*sim(net_fang,input);

for i = 2:size(pos_acts,1)
     input = [state; pos_acts(i,:)];
     output(i,:) = tradeoff*sim(net_en, input)+(1-tradeoff)*sim(net_fang,input);
end

[min_val, idxs] = min(output);

end