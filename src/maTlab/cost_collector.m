%========================================================================
%|National Technical University of Athens                               |
%|School of Electrical & Computer Engineering                           |
%|Microprocessors & Digital Systems Lab                                 |
%|----------------------------------------------------------------------|
%|"Realization of an Energy Management System for Commercial Buildings" |
%|Undergraduate Thesis                                                  |
%========================================================================

%The following script attributes a cost for a given transition tuple, and
%decides whether or not the constant-setpoint agent should be deployed. It
%also gives information regarding the readiness of an agent (C == 0).

%A state is like this: S = [T_out actsleft fanger T_in]
%The variable actsleft shows how many actions are there until the end of
%the schedule.

function [C, go_constant, episodes, me_r, se_r, mf_r, sf_r] = cost_collector(energy_spent, transition, episodes, state_idxs)

persistent e_vec f_vec me se mf sf se_old sf_old me_old mf_old

e_vec = [e_vec energy_spent];
f_vec = [f_vec abs(transition(12))];

if length(e_vec) > 1
    me = me_old + (energy_spent-me_old)/length(e_vec);
    mf = mf_old + (abs(transition(12))-mf_old)/length(f_vec);
    se_new = se_old + (energy_spent-me_old)*(energy_spent-me);
    se = sqrt(se_new/(length(f_vec)-1));
    sf_new = sf_old + (abs(transition(12))-mf_old)*(abs(transition(12))-mf);
    sf = sqrt(sf_new/(length(f_vec)-1));
    me_old = me; mf_old = mf; se_old = se_new; sf_old = sf_new;
    me_r = me; se_r = se; mf_r = mf; sf_r = sf;
else
    se_old = 0; sf_old = 0; me_old = e_vec(1); mf_old = f_vec(1);
    me_r = me_old; se_r = se_old; mf_r = mf_old; sf_r = sf_old;
end

go_constant = false;

start_state = transition(state_idxs);
end_state = transition(state_idxs);

%S_+: region_id == 1
%S_-: region_id == 2
%elsewhere: region_id == 3

start_region = region_id(transition(2:7));
end_region = region_id(transition(9:14));
trans_spec = transition_id(start_region, end_region, transition(5), transition(12));

tradeoff = 0;

C = coolest_collector(energy_spent, transition(5), transition(12), tradeoff, false, me, se, mf, sf);

if C == 10
    go_constant = true;
    episodes = episodes+1;
else
    disp(['Good transition. Cost was ' num2str(C) ', trans_spec was ' num2str(trans_spec)]);
end

    
end