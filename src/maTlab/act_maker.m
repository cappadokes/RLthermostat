%========================================================================
%|National Technical University of Athens                               |
%|School of Electrical & Computer Engineering                           |
%|Microprocessors & Digital Systems Lab                                 |
%|----------------------------------------------------------------------|
%|"Realization of an Energy Management System for Commercial Buildings" |
%|Undergraduate Thesis                                                  |
%========================================================================

%This function is basically a 'decoder' for our thermostat's actions. Each
%time, what the agent truly sees are the options:

% IDLE == 1
% HEATMUCH == 2
% COOLMUCH == 3
% HEATSOME == 4
% COOLSOME == 5

function actions_possible = act_maker(t_in)

actions_possible = [t_in; t_in+1; t_in-1];

end
