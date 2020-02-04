clear; clc;
length_sim = 2160*2;
load parameters.mat;

load Results_20_1_30.mat;
%load Results_20_201_230.mat;
en_const_1 = results{1}(:,3);
fang_const_1 = results{1}(:,4);
%perf_const_1 = get_my_scores(trade_off, start_hour, end_hour, timesteps, 201230, length_sim, 1);
perf_const_1 = get_my_scores(trade_off, start_hour, end_hour, timesteps, 130, length_sim, 1);
[dayen_const_1, ~] = convert_to_daily(en_const_1, start_hour, end_hour, timesteps, length_sim);
dayfang_const_1 = convert_to_daily(fang_const_1, start_hour, end_hour, timesteps, length_sim);
dayperf_const_1 = convert_to_daily(perf_const_1, start_hour, end_hour, timesteps, length_sim);

load Results_21_1_30.mat;
%load Results_21_201_230.mat;
en_const_2 = results{1}(:,3);
fang_const_2 = results{1}(:,4);
%perf_const_2 = get_my_scores(trade_off, start_hour, end_hour, timesteps, 201230, length_sim, 2);
perf_const_2 = get_my_scores(trade_off, start_hour, end_hour, timesteps, 130, length_sim, 2);
[dayen_const_2, dayz] = convert_to_daily(en_const_2, start_hour, end_hour, timesteps, length_sim);
dayfang_const_2 = convert_to_daily(fang_const_2, start_hour, end_hour, timesteps, length_sim);
dayperf_const_2 = convert_to_daily(perf_const_2, start_hour, end_hour, timesteps, length_sim);

load Results_22_1_30.mat;
%load Results_22_201_230.mat;
en_const_3 = results{1}(:,3);
fang_const_3 = results{1}(:,4);
%perf_const_3 = get_my_scores(trade_off, start_hour, end_hour, timesteps, 201230, length_sim, 3);
perf_const_3 = get_my_scores(trade_off, start_hour, end_hour, timesteps, 130, length_sim, 3);
[dayen_const_3, dayz] = convert_to_daily(en_const_3, start_hour, end_hour, timesteps, length_sim);
dayfang_const_3 = convert_to_daily(fang_const_3, start_hour, end_hour, timesteps, length_sim);
dayperf_const_3 = convert_to_daily(perf_const_3, start_hour, end_hour, timesteps, length_sim);

load Results_23_1_30.mat;
%load Results_23_201_230.mat;
en_const_4 = results{1}(:,3);
fang_const_4 = results{1}(:,4);
%perf_const_4 = get_my_scores(trade_off, start_hour, end_hour, timesteps, 201230, length_sim, 4);
perf_const_4 = get_my_scores(trade_off, start_hour, end_hour, timesteps, 130, length_sim, 4);
[dayen_const_4, dayz] = convert_to_daily(en_const_4, start_hour, end_hour, timesteps, length_sim);
dayfang_const_4 = convert_to_daily(fang_const_4, start_hour, end_hour, timesteps, length_sim);
dayperf_const_4 = convert_to_daily(perf_const_4, start_hour, end_hour, timesteps, length_sim);

load Results_24_1_30.mat;
%load Results_24_201_230.mat;
en_const_5 = results{1}(:,3);
fang_const_5 = results{1}(:,4);
%perf_const_5 = get_my_scores(trade_off, start_hour, end_hour, timesteps, 201230, length_sim, 5);
perf_const_5 = get_my_scores(trade_off, start_hour, end_hour, timesteps, 130, length_sim, 5);
[dayen_const_5, dayz] = convert_to_daily(en_const_5, start_hour, end_hour, timesteps, length_sim);
dayfang_const_5 = convert_to_daily(fang_const_5, start_hour, end_hour, timesteps, length_sim);
dayperf_const_5 = convert_to_daily(perf_const_5, start_hour, end_hour, timesteps, length_sim);

load Results_25_1_30.mat;
%load Results_25_201_230.mat;
en_const_7 = results{1}(:,3);
fang_const_7 = results{1}(:,4);
%perf_const_7 = get_my_scores(trade_off, start_hour, end_hour, timesteps, 201230, length_sim, 7);
perf_const_7 = get_my_scores(trade_off, start_hour, end_hour, timesteps, 130, length_sim, 7);
[dayen_const_7, dayz] = convert_to_daily(en_const_7, start_hour, end_hour, timesteps, length_sim);
dayfang_const_7 = convert_to_daily(fang_const_7, start_hour, end_hour, timesteps, length_sim);
dayperf_const_7 = convert_to_daily(perf_const_7, start_hour, end_hour, timesteps, length_sim);

load Results_26_1_30.mat;
%load Results_26_201_230.mat;
en_const_8 = results{1}(:,3);
fang_const_8 = results{1}(:,4);
%perf_const_8 = get_my_scores(trade_off, start_hour, end_hour, timesteps, 201230, length_sim, 8);
perf_const_8 = get_my_scores(trade_off, start_hour, end_hour, timesteps, 130, length_sim, 8);
[dayen_const_8, dayz] = convert_to_daily(en_const_5, start_hour, end_hour, timesteps, length_sim);
dayfang_const_8 = convert_to_daily(fang_const_5, start_hour, end_hour, timesteps, length_sim);
dayperf_const_8 = convert_to_daily(perf_const_5, start_hour, end_hour, timesteps, length_sim);

load Results_27_1_30.mat;
%load Results_27_201_230.mat;
en_const_9 = results{1}(:,3);
fang_const_9 = results{1}(:,4);
%perf_const_9 = get_my_scores(trade_off, start_hour, end_hour, timesteps, 201230, length_sim, 9);
perf_const_9 = get_my_scores(trade_off, start_hour, end_hour, timesteps, 130, length_sim, 9);
[dayen_const_9, dayz] = convert_to_daily(en_const_5, start_hour, end_hour, timesteps, length_sim);
dayfang_const_9 = convert_to_daily(fang_const_5, start_hour, end_hour, timesteps, length_sim);
dayperf_const_9 = convert_to_daily(perf_const_5, start_hour, end_hour, timesteps, length_sim);

load Results.mat;
zone1 = results{1};
hourscale = 0:1/timesteps:length(controlTotal)/timesteps;
hourscale = hourscale (1:length(hourscale)-1);
%==========================================================================
%Total Results follow.

roomtemp = zone1(:,1);
roomfang = zone1(:,4);
roomeng = zone1(:,3);
roomcont = controlTotal(:,1);

perf_nfq = get_my_scores(trade_off, start_hour, end_hour, timesteps, 0, length_sim);

dayen_nfq = convert_to_daily(roomeng, start_hour, end_hour, timesteps, length_sim);
dayfang_nfq = convert_to_daily(roomfang, start_hour, end_hour, timesteps, length_sim);
dayperf_nfq = convert_to_daily(perf_nfq, start_hour, end_hour, timesteps, length_sim);

figure;
subplot(2,1,1);
plot(hourscale, roomtemp); hold on;
plot(hourscale, weather_file(:,1));
ylabel('Temperature');
xlabel('Simulation Hours');
subplot(2,1,2);
plot(hourscale, roomfang);
ylabel('PMV');
xlabel('Simulation Hours');
figure;
plot(hourscale, roomfang);
hold on; plot(hourscale, fang_const_1);
hold on; plot(hourscale, fang_const_2);
hold on; plot(hourscale, fang_const_3);
hold on; plot(hourscale, fang_const_4);
hold on; plot(hourscale, fang_const_5);
hold on; plot(hourscale, fang_const_7);
hold on; plot(hourscale, fang_const_8);
hold on; plot(hourscale, fang_const_9);
title('Thermal Comfort Comparison');
ylabel('PMV');
xlabel('Simulation Hours');
legend('Proposed','RBC 20','RBC 21','RBC 22','RBC 23','RBC 24', 'RBC 25', 'RBC 26', 'RBC 27');

toten_nfq = sum(roomeng);
toten_const_1 = sum(en_const_1);
toten_const_2 = sum(en_const_2);
toten_const_3 = sum(en_const_3);
toten_const_4 = sum(en_const_4);
toten_const_5 = sum(en_const_5);
toten_const_7 = sum(en_const_7);
toten_const_8 = sum(en_const_8);
toten_const_9 = sum(en_const_9);

figure;
plot(hourscale, roomeng); hold on; plot(hourscale, en_const_1);
hold on; plot(hourscale, en_const_2);
hold on; plot(hourscale, en_const_3);
hold on; plot(hourscale, en_const_4);
hold on; plot(hourscale, en_const_5);
hold on; plot(hourscale, en_const_7);
hold on; plot(hourscale, en_const_8);
hold on; plot(hourscale, en_const_9);
title('Consumption Comparison');
legend('Proposed','RBC 20','RBC 21','RBC 22','RBC 23','RBC 24', 'RBC 25', 'RBC 26', 'RBC 27');
ylabel('Energy');
xlabel('Simulation Hours');

figure;
plot(perf_nfq); hold on; plot(perf_const_1);
hold on; plot(perf_const_2);
hold on; plot(perf_const_3);
hold on; plot(perf_const_4);
hold on; plot(perf_const_5);
hold on; plot(perf_const_7);
hold on; plot(perf_const_8);
hold on; plot(perf_const_9);
legend('Proposed','RBC 20','RBC 21','RBC 22','RBC 23','RBC 24', 'RBC 25', 'RBC 26', 'RBC 27');
title('Performance Comparison');
ylabel('Total Score');
xlabel('Control Steps');

figure;
plot(dayz, dayperf_nfq); hold on; plot(dayz, dayperf_const_1);
hold on; plot(dayz, dayperf_const_2);
hold on; plot(dayz, dayperf_const_3);
hold on; plot(dayz, dayperf_const_4);
hold on; plot(dayz, dayperf_const_5);
hold on; plot(dayz, dayperf_const_7);
hold on; plot(dayz, dayperf_const_8);
hold on; plot(dayz, dayperf_const_9);
legend('Proposed','RBC 20','RBC 21','RBC 22','RBC 23','RBC 24', 'RBC 25', 'RBC 26', 'RBC 27');
title('Daily Performance Comparison');
ylabel('Total Score');
xlabel('Day');
figure;
plot(dayz, dayen_nfq); hold on; plot(dayz, dayen_const_1);
hold on; plot(dayz, dayen_const_2);
hold on; plot(dayz, dayen_const_3);
hold on; plot(dayz, dayen_const_4);
hold on; plot(dayz, dayen_const_5);
hold on; plot(dayz, dayen_const_7);
hold on; plot(dayz, dayen_const_8);
hold on; plot(dayz, dayen_const_9);
legend('Proposed','RBC 20','RBC 21','RBC 22','RBC 23','RBC 24', 'RBC 25', 'RBC 26', 'RBC 27');
title('Daily Consumption Comparison');
ylabel('Energy');
xlabel('Day');