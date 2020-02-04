function myscores = get_my_scores(tradeoff, sched_start, sched_end, timesteps, choice, length_sim, sechoice, E_max)

switch choice
    case 0
        load Results.mat;
    case 115
        load Results_23_1_15.mat;
    case 130
        switch sechoice
            case 0
                load Results_20_21_50.mat; 
            case 1
                load Results_21_21_50.mat;
            case 2
                load Results_22_21_50.mat;
            case 3
                load Results_23_21_50.mat;
            case 4
                load Results_24_21_50.mat;
            case 5
                load Results_25_21_50.mat;
            case 6
                load Results_26_21_50.mat;       
            case 7
                load Results_27_21_50.mat; 
        end
    case 201215
        load Results_25_201_215.mat;
    case 160
        load Results_23_1_60.mat;
    case 201260
        load Results_25_201_260.mat;
    case 201230
        switch sechoice
            case 0
                load Results_20_221_250.mat;
            case 1
                load Results_21_221_250.mat;
            case 2
                load Results_22_221_250.mat;
            case 3
                load Results_23_221_250.mat;
            case 4
                load Results_24_221_250.mat;
            case 5
                load Results_25_221_250.mat;
            case 6
                load Results_26_221_250.mat;
            case 7
                load Results_27_221_250.mat;
        end
    case 1120
        switch sechoice
            case 0
                load Results_20_1_90.mat;
            case 1
                load Results_21_1_90.mat;
            case 2
                load Results_22_1_90.mat;
            case 3
                load Results_23_1_90.mat;
            case 4
                load Results_24_1_90.mat;
            case 5
                load Results_25_1_90.mat;
            case 6
                load Results_26_1_90.mat;
            case 7
                load Results_27_1_90.mat;
        end
    case 121240
        switch sechoice
            case 0
                load Results_20_151_240.mat; 
            case 1
                load Results_21_151_240.mat;
            case 2
                load Results_22_151_240.mat;
            case 3
                load Results_23_151_240.mat;
            case 4
                load Results_24_151_240.mat;
            case 5
                load Results_25_151_240.mat;
            case 6
                load Results_26_151_240.mat;
            case 7
                load Results_27_151_240.mat; 
        end
end

zone1 = results{2};

ens = zone1(:,3);
[me, se] = mother_of_accuracy(ens, 10, 6, 21);

fangs = zone1(:,4);
[mf, sf] = mother_of_accuracy(fangs, 10, 6, 21);

sched_start = timesteps*sched_start;
sched_end = timesteps*sched_end;

count = 1;

myscores = zeros(1,length_sim);

while count <= length(ens)
    t_d = mod(count,24*timesteps);
    while t_d ~= sched_start && count <= length(ens)
        count = count+1;
        t_d = mod(count,24*timesteps);
    end
    
    while t_d ~= sched_end && count <= length(ens)
        start_fang = fangs(count-1);
        end_fang = fangs(count);
        energy_spent = ens(count);
        myscores(count) = coolest_collector(energy_spent, start_fang, end_fang, tradeoff, true, me, se, mf, sf);
        count = count+1;
        t_d = mod(count,24*timesteps);
    end
end

end