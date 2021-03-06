%==========================================================================
%Results regarding the learning process follow.

load RL_package.mat;

sched_start = start_hour*timesteps;
[episode_lengths, episode_costs] = global_episode_data(full_trans, TB);

figure;
subplot(2,1,1);
plot(episode_lengths);
ylabel('Length');
subplot(2,1,2);
plot(episode_costs);
ylabel('Cost per timestep');
xlabel('Episodes after first batch completion');

figure;
subplot(1,2,1);
histogram(TB(size(TB,1)-1,:));
title('Actions');
xlabel('Action taken');
ylabel('Nr. of occurencies');
subplot(1,2,2);
histogram(TB(size(TB,1),:));
title('Costs');
xlabel('Cost per timestep');

figure;
subplot(2,1,1);
plot(TD);
ylabel('TD-error');
xlabel('Timesteps after 1st batch');
subplot(2,1,2);
histogram(TD);
ylabel('Occurencies');
xlabel('TD-error');
maskman = find(isnan(TD) == 1);
maskman_2 = find(isinf(TD) == 1);
if ~isempty(maskman) || ~isempty(maskman_2)
    if ~isempty(maskman)
        max = maskman(end)+1;
        if ~isempty(maskman_2) && (maskman_2(end)+1) > max
            max = maskman_2(end)+1;
        end
    else
        max = maskman_2(end)+1;
    end
    rmse = mean(TD(max:end).^2);
else
    rmse = mean(TD.^2);
end
title(['Mean Square TD-error = ' num2str(rmse)]);

figure;
subplot(1,2,1);
plot(lambda_vec);
ylabel('Success Rate (λ)');
subplot(1,2,2);
plot(e_vec)
ylabel('Exploration Rate (ε)');
rmse = mean(TD);

%==========================================================================