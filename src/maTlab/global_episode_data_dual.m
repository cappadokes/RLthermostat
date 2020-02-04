function [lengths, costs] = global_episode_data_dual(full_trans, TB_en, TB_fang, tradeoff)

lengths = []; costs = [];
sched_start = full_trans(1,1);
locvec = find(full_trans(1,:) == sched_start);
start_idx = locvec(2);
count = start_idx;

while count < size(full_trans,2)
    loc_length = 1;
    cost_sum = tradeoff*TB_en(size(TB_en,1),start_idx) + (1-tradeoff)*TB_fang(size(TB_fang,1), start_idx);
    end_found = false;
    while ~end_found && (count < size(full_trans,2))
        if (full_trans(1,count+1) == (full_trans(1,count)+2))
            loc_length = loc_length+1;
            cost_sum = tradeoff*TB_en(size(TB_en,1),count+1) + (1-tradeoff)*TB_fang(size(TB_fang,1), count+1);
        else
            end_found = true;
            start_idx = count+1;
            lengths = [lengths loc_length];
            costs = [costs cost_sum];
        end
        count = count+1;
    end
end

end