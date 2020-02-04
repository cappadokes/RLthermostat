%========================================================================
%|National Technical University of Athens                               |
%|School of Electrical & Computer Engineering                           |
%|Microprocessors & Digital Systems Lab                                 |
%|----------------------------------------------------------------------|
%|"Realization of an Energy Management System for Commercial Buildings" |
%|Undergraduate Thesis                                                  |
%========================================================================

function [min_val, idxs] = best_action_value(state, pos_acts, old_net)

input = [state; pos_acts(1,:)];
%input = [state; ones(1,size(state,2))];
output(1,:) = sim(old_net, input);

for i = 2:size(pos_acts,1)
     input = [state; pos_acts(i,:)];
     %input = [state; i*ones(1,size(state,2))];
     output(i,:) = sim(old_net, input);
end

[min_val, idxs] = min(output);

end