%========================================================================
%|National Technical University of Athens                               |
%|School of Electrical & Computer Engineering                           |
%|Microprocessors & Digital Systems Lab                                 |
%|----------------------------------------------------------------------|
%|"Realization of an Energy Management System for Commercial Buildings" |
%|Undergraduate Thesis                                                  |
%========================================================================

function s = state_maker(eplus_receive, temps, hums, current_fanger, occupants)

roomtemps = eplus_receive(temps);
roomhums = eplus_receive(hums);
out_temp = eplus_receive(1);

%t_d = mod(time,24*timesteps);
radiation = eplus_receive(3);

%This is the current state that the agent will see in order to choose an
%action.
s = [out_temp roomhums(2) radiation current_fanger roomtemps(2) occupants]';

end
