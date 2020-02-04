%========================================================================
%|National Technical University of Athens                               |
%|School of Electrical & Computer Engineering                           |
%|Microprocessors & Digital Systems Lab                                 |
%|----------------------------------------------------------------------|
%|"Realization of an Energy Management System for Commercial Buildings" |
%|Undergraduate Thesis                                                  |
%========================================================================

function agent_save(net, episode_num, tr)

name = 'agents_tested.mat';
if exist(name, 'file') == 2
    clearvars -except net;
    load agents_ready.mat;
    node = cell(3,1);
    node{1,1} = net;
    node{2,1} = episode_num;
    node{3,1} = tr;
    agents_nest = [agents_nest node];
else
    agents_nest = cell(3,1);
    agents_nest{1,1} = net;
    agents_nest{2,1} = episode_num;
    agents_nest{3,1} = tr;
end

save agents_ready.mat agents_nest;

end