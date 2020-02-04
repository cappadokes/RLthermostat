%========================================================================
%|National Technical University of Athens                               |
%|School of Electrical & Computer Engineering                           |
%|Microprocessors & Digital Systems Lab                                 |
%|----------------------------------------------------------------------|
%|"Realization of an Energy Management System for Commercial Buildings" |
%|Undergraduate Thesis                                                  |
%========================================================================

function [patterns, targets] = data_extraction_cont(TB, old_net, g)

%The last line of the transition base includes the cost that arised from
%every state-action pair observed.
real_out = -TB(size(TB,1), :);
%[net_out, ps] = mapstd(real_out);

%We first scale the costs in order to fit in the logsig properly...
A = 1/(max(real_out) - min(real_out));
B = -min(real_out)/(max(real_out) - min(real_out));

%{
mask = find(real_out ~= 30);

if isempty(old_net)
    real_out(mask) = real_out(mask)+g*inverse_scale(rand(1,length(mask)), A, B);
else
    if mask < length(real_out)
        acts = act_maker(TB(size(TB,1)-2, mask+1));
        %[bestval, idx] = best_action_value(TB(1:(size(TB,1)-2),mask+1), acts, old_net);
        [bestval, idx] = action_selection(TB(1:(size(TB,1)-2),mask+1), acts, old_net, 50);
        real_out(mask) = -real_out(mask)+g*inverse_scale(bestval, A, B);
    end
end

A = 1/(max(real_out) - min(real_out));
B = -min(real_out)/(max(real_out) - min(real_out));
%}

%The scaled version of the desired outputs is thus...
net_out = A*real_out+B;
TB = [TB(1:(size(TB,1)-1),:); net_out];

%We also shuffle the input, for preprocessing reasons.
TB = TB(:,randperm(size(TB,2)));
patterns = TB(1:(size(TB,1)-1),:); targets = TB(size(TB,1),:);

end