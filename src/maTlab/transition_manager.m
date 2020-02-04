if go_constant
    disp('Constant-setpoint controller did the job.');
    start_state = current_state;
    go_constant = false;
else
    if t_c == 0
        disp('Agent just grabbed control. No action taken yet.');
        if ~isempty(net)
            [TB, mini_TB] = trendfollower(TB, evec, fvec, me_node, se_node, mf_node, sf_node, tradeoff);
            [net, tr, A, B] = neural_trainer(episodes, mini_TB, net, g);
        end
        start_state = current_state;
    else
        disp('Evaluating the last action of the agent...');
        end_state = current_state;
        transition = [t_d-2; start_state; action_taken; end_state];
        unmet = false;
        if (abs(transition(8)-transition(13)) > 0.5)
            unmet = true;
            unmet_timesteps = unmet_timesteps+1;
        end
        state_idxs = [2 4 6 3];
        [C, go_constant, episodes, me_node, se_node, mf_node, sf_node] = cost_collector(energy(time,2), transition, episodes, state_idxs);
        me = [me me_node]; se = [se se_node]; mf = [mf mf_node]; sf = [sf sf_node];
        if unmet
            transition(8) = transition(13)-0.1+0.2*rand;
            action_taken = transition(8);
        end
        full_trans = [full_trans transition];
        disp('Updating transition database...');
        if (~isempty(net) && t_d < end_of_watch)
            disp('Getting TD-error...');
            TD = get_td_error(TD, prediction, [current_state(1); current_state(3); current_state(5); current_state(2)], C, net, g, A, B);
        end
        temp = start_state;
        start_state = [start_state(1); start_state(3); start_state(5); start_state(2)];
        evec = [evec energy(time,2)]; fvec = [fvec abs(transition(12))];
        [TB, mini_TB] = update_tb(TB, start_state, C, action_taken);
        start_state = temp;
        if go_constant
            if ~unmet
                disp('Agent failed. Constant controller has been called. Training new agents...');
                [TB, mini_TB] = trendfollower(TB, evec, fvec, me_node, se_node, mf_node, sf_node, tradeoff);
                [net, tr, A, B] = neural_trainer(episodes, mini_TB, net, g);
            end
        else
            start_state = current_state; 
        end
    end
end