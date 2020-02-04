%========================================================================
%|National Technical University of Athens                               |
%|School of Electrical & Computer Engineering                           |
%|Microprocessors & Digital Systems Lab                                 |
%|----------------------------------------------------------------------|
%|"Realization of an Energy Management System for Commercial Buildings" |
%|Undergraduate Thesis                                                  |
%========================================================================

%The following function lets either the NFQ agent or a constant-setpoint
%dummy controller to se the setpoint of the next timestep. 

function [setpoint_1, t_c, agent_acted, prediction] = dummy(e, message, net, current_state, actions_possible, go_constant, t_c)

prediction = rand;

if go_constant
    setpoint_1 = const_cont(current_state(5), current_state(4));
    t_c = 0;
    disp(['Constant setpoint deployed.' message]);
    agent_acted = false;
    return;
else
    chance = rand;
    if isempty(net)    
        setpoint_1 = actions_possible(randi(length(actions_possible)));
    else
        if chance > e
            [prediction,idx] = best_action_value([current_state(1); current_state(3); current_state(5); current_state(2)], actions_possible, net);
        else
            idx = randi(length(actions_possible));
            prediction = sim(net, [current_state(1); current_state(3); current_state(5); current_state(2); actions_possible(idx)]);
        end
        setpoint_1 = actions_possible(idx);
        if setpoint_1 > 28
            setpoint_1 = 28;
        end
        if setpoint_1 < 15
            setpoint_1 = 15;
        end
    end
    t_c = t_c+1;
    agent_acted = true;
    disp(['Agent acted.' message]);
    return;
end

end