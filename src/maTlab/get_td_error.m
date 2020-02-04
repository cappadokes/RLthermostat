function TD = get_td_error (TD, pred, current_state, C, net, g, A, B)

acts = act_maker(current_state(length(current_state)-1));
right_pred = A*(C + g*inverse_scale(best_action_value(current_state, acts, net),A,B))+B;
node = abs(right_pred-pred);

TD = [TD node];

end
