function [lengths, costs] = global_episode_data(full_trans, TB)

lengths = []; costs = [];
sched_start = full_trans(1,1);
locvec = morningfinder(full_trans(1,:));
start_idx = locvec(2);
count = start_idx;

while count < size(full_trans,2)
    loc_length = 1;
    cost_sum = TB(size(TB,1),start_idx);
    end_found = false;
    while ~end_found && (count < size(full_trans,2))
        if (full_trans(1,count+1) == (full_trans(1,count)+2))
            loc_length = loc_length+1;
            cost_sum = cost_sum+TB(size(TB,1),count+1);
        else
            end_found = true;
            start_idx = count+1;
            lengths = [lengths loc_length];
            costs = [costs cost_sum/loc_length];
        end
        count = count+1;
    end
end

end