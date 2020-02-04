%========================================================================
%|National Technical University of Athens                               |
%|School of Electrical & Computer Engineering                           |
%|Microprocessors & Digital Systems Lab                                 |
%|----------------------------------------------------------------------|
%|"Realization of an Energy Management System for Commercial Buildings" |
%|Undergraduate Thesis                                                  |
%========================================================================

clearvars -global;
delete Actions.mat clothing.mat INDEXES.mat parameters.mat people.mat agents_ready.mat
clear; clc;

%This script is responsible for training an agent via the Neural Fitted
%Q-Iteration technique.

initializer;
trade_off = 0;
startSimulation(hvac_type, start_day, end_day, start_hour, end_hour, timesteps, 10, trade_off, occupants, 20*0.75);

figure;

length_sim = (end_day-start_day+1)*24*timesteps;
if hvac_type == 2
    plotter;
    sec_plotter;
end