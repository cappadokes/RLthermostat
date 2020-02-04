%========================================================================
%|National Technical University of Athens                               |
%|School of Electrical & Computer Engineering                           |
%|Microprocessors & Digital Systems Lab                                 |
%|----------------------------------------------------------------------|
%|"Realization of an Energy Management System for Commercial Buildings" |
%|Undergraduate Thesis                                                  |
%========================================================================

%The building simulation starts from this script.

clearvars -global;
delete Actions.mat clothing.mat INDEXES.mat parameters.mat people.mat Results.mat
clear; clc;

initializer;

for current_season = 1:seasons
    startSimulation(sarstep, train_choice, current_season, hvac_type, start_day, end_day, start_hour, end_hour, timesteps, 10, 0.5, occupants, 20*0.75);
end

%To this point, the simulation has ended and the results have been saved.
%Now it's time to plot some stuff...

load RL_package.mat;

choice = -1;
while choice ~= 0
    prompt = ('Simulation has finished. To plot data of the last season for a certain zone, enter relative number. To plot total results (still last season) enter 11. To stop plotting, enter 0: ');
    choice = input(prompt);
    if (choice < 0) || (choice > 11)
        continue;
    elseif (choice <= 11) && (choice > 0)
        zone_plotter;
    end
end


%if train_choice == 1
    choice = -1;
    while choice ~= 0
        prompt = ('To plot reward data for all seasons, enter 1. To do nothing, enter 0: ');
        choice = input(prompt);
        if (choice == 1)
            hope = reward_sum_per_episode(past_rewards, start_hour, end_hour, timesteps);
            figure;
            plot(hope);
            ylabel('Reward Sum Per Episode');
            xlabel('i-th Episode');
            break;
        end
    end
%end

clearvars;
clearvars -global;