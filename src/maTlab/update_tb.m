%========================================================================
%|National Technical University of Athens                               |
%|School of Electrical & Computer Engineering                           |
%|Microprocessors & Digital Systems Lab                                 |
%|----------------------------------------------------------------------|
%|"Realization of an Energy Management System for Commercial Buildings" |
%|Undergraduate Thesis                                                  |
%========================================================================

%function [TB, mini_TB] = update_tb(TB, last_state, last_cost, last_action, olde_max, energy_buffer, tradeoff)
function [TB, mini_TB] = update_tb(TB, last_state, last_cost, last_action)

node = [last_state; last_action; last_cost];
TB = [TB node];

start_idx = 1;
%start_idx = max(1, size(TB,2) - 500 + 1);

mini_TB = TB(:,start_idx:end);

end