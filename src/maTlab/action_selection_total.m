function [bestval,idx] = action_selection_total(w, cont_net, state, pos_acts, net, T)

[bestval1, idx1, probz_Q] = action_selection(state, pos_acts, net, T);
[bestval2, idx2, probz_C] = action_selection(state, pos_acts, cont_net, T);

totvec = (1-w)*probz_Q-w*probz_C;
[bestval, idx] = min(totvec);

end