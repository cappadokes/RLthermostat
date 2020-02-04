%========================================================================
%|National Technical University of Athens                               |
%|School of Electrical & Computer Engineering                           |
%|Microprocessors & Digital Systems Lab                                 |
%|----------------------------------------------------------------------|
%|"Realization of an Energy Management System for Commercial Buildings" |
%|Undergraduate Thesis                                                  |
%========================================================================

function [patterns, targets, A, B] = data_extraction(TB, old_net, g)

%The last line of the transition base includes the cost that arised from
%every state-action pair observed.
real_out = TB(size(TB,1), :);

mask = find(TB(end,:) ~= 10);
if ~isempty(mask) && mask(end) == size(TB,2)
    mask = mask(1:end-1);
end

%We first scale the costs in order to fit in the logsig properly...
A = 1/(max(real_out) - min(real_out));
B = -min(real_out)/(max(real_out) - min(real_out));

if isempty(old_net)
    real_out(mask) = real_out(mask)+g*inverse_scale(rand(1,length(mask)), A, B);
else
    acts = act_maker(TB(size(TB,1)-3, mask+1));
    [bestval, idx] = best_action_value(TB(1:(size(TB,1)-2),mask+1), acts, old_net);
    real_out(mask) = real_out(mask)+g*inverse_scale(bestval, A, B);
end

A = 1/(max(real_out) - min(real_out));
B = -min(real_out)/(max(real_out) - min(real_out));

%The scaled version of the desired outputs is thus...
net_out = A*real_out+B;
TB = [TB(1:(size(TB,1)-1),:); net_out];

patterns = TB(1:(size(TB,1)-1),:); targets = TB(size(TB,1),:);

end