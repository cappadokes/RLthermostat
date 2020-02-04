%========================================================================
%|National Technical University of Athens                               |
%|School of Electrical & Computer Engineering                           |
%|Microprocessors & Digital Systems Lab                                 |
%|----------------------------------------------------------------------|
%|"Realization of an Energy Management System for Commercial Buildings" |
%|Undergraduate Thesis                                                  |
%========================================================================

function [TB_en, TB_fang] = update_tb_dual(TB_en, TB_fang, last_state, C_en, C_fang, last_action)

initial_temp = last_state(length(last_state));

switch last_action
    case initial_temp+1
        last_action = 2;
    case initial_temp-1
        last_action = 3;
    case initial_temp+0.5
        last_action = 4;
    case initial_temp-0.5
        last_action = 5;
    case initial_temp
        last_action = 1;
end

node = [last_state; last_action; C_en];
TB_en = [TB_en node];

node = [last_state; last_action; C_fang];
TB_fang = [TB_fang node];

end