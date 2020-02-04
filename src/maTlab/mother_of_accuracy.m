function [me, se] = mother_of_accuracy(vec, timestep, sched_start, sched_end)

accuvec = [];

for i = 1:length(vec)
    hour = i*timestep/60;
    if mod(hour,24) > sched_start && mod(hour,24) <= sched_end
        node = abs(vec(i));
        accuvec = [accuvec node];
        if length(accuvec) > 1
            me = me_old + (node-me_old)/length(accuvec);
            se_new = se_old + (node-me_old)*(node-me);
            se = sqrt(se_new/(length(accuvec)-1));
            me_old = me; se_old = se_new;
        else
            se_old = 0; me_old = node; 
        end        
    end
end

end