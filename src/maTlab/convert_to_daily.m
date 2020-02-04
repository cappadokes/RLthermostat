function [daydata, dayzvec] = convert_to_daily(in_vec, start_hour, end_hour, timesteps, length_sim)

time = 1:length_sim;
start_idxs = find(mod(time,24*timesteps) == start_hour*timesteps);
end_idxs = find(mod(time,24*timesteps) == end_hour*timesteps);

count = 1;
daydata = zeros(1,length(start_idxs));

while count <= length(start_idxs)
    dayvec = in_vec(start_idxs(count):end_idxs(count));
    daydata(count) = sum(dayvec);
    count = count+1;
end

dayzvec = 1:length(start_idxs);

end