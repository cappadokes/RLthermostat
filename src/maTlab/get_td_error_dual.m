function TD = get_td_error_dual (TD, current_state, C, net_en, net_fang, g, action_taken, tradeoff)

pred_en = sim(net_en, [current_state; action_taken]);
pred_fang = sim(net_fang, [current_state; action_taken]);
pred = tradeoff*pred_en+(1-tradeoff)*pred_fang;

acts = act_maker(current_state(length(current_state)));
node = abs(C/90 + g*best_action_value_dual(current_state, acts, net_en, net_fang, tradeoff) - pred);
TD = [TD node];

end
