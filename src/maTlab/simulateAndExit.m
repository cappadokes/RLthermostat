% This is the main simulation script witch is called every timestep of the simulations and exchanges the data between EnergyPlus and Matlab
%
%   Every timestep:     EnergyPlus <--- data ---> simulateAndExit.m
%                           

load parameters.mat;

tradeoff = trade_off;

load people.mat;
% initialize vectors for sending and receiving data
delTim    = 60*60/timesteps;                % time step of the simulation
eplus_receive = ones(1,3+8*zone_number+2);  % the reports of energyplus every timestep
eplus_send = 24*ones(1,4*zone_number);      % the schedule values (setpoints) that we send to energyplus every timestep
% make vectors with indexes of the data in eplus_send eplus_receive
heatings = 1:2:2*zone_number-1;           % heating setpoints indexes
coolings = 2:2:2*zone_number;             % cooling setpoint indexes
temps = 4:5:3+5*zone_number-4;            % temperature indexes
hums = 5:5:3+5*zone_number-3;             % humidity indexes

pmvs = [6:5:3+5*zone_number-2];

%pmvs = [6:5:3+5*zone_number-2];

energy_heat = 7:5:3+5*zone_number-1;      % energy consumption of cooling
energy_cool = 8:5:3+5*zone_number;        % energy consumption of heating

peoplenum = 54:1:54+zone_number-1;        % room number of people indexes
setpeople = 21:1:21+zone_number-1;        % set number of people indexes

% coolings on summer heatings on winter for hvac and clothing insulation

if (start_day<91 || start_day>273)
    cooling_heating = 2;
    clothing = 0.8;
else
    cooling_heating = 1;
    clothing = 0.6;
end
%save clothing.mat clothing;
% initialize flags for exchangeDoublesWithSocket
retVal    = 0;
flaWri    = 0;
flaRea    = 0;
simTimWri = 0;
simTimRea = 0;
counter_people = 1;
time=1;

%Each episode ends when the schedule ends.
schedule_length = 44;

% calculate the length of the simulation
length_sim = (end_day-start_day+1)*24*timesteps;

if (hvac_type == 1)
    % load actions for setpoints
    load Actions.mat;
    counter=1;
else
    %==========================================================================
    %Initialize some useful variables for the NFQ implementation.
        go_constant = false; t_c = 0; episodes = 0;
        unmet_timesteps = 0;
        %t_c is like an internal episode clock. We don't know the length of every
        %next episode, so we need this'
        %Our state consists of: {T_out, actsleft, Fanger, T_in}
        end_state = [];
        start_state = [];
        action_taken = [];
        %net_en = []; net_fang = net_en;
        %TB_en = []; TB_fang = [];
        net = []; TB = []; A = []; B = []; mini_TB = [];
        evec = []; fvec = []; me = []; se = []; mf = []; sf = [];
        me_node = []; mf_node = []; se_node = []; sf_node = [];
        tr = []; 
        setpoint_1 = []; full_trans = [];
        %g is our discounting parameter. It's large, as we value future
        %costs a lot.
        g = 0.98; 
        e_0 = []; k = 0.5; agent_ready = false; lambda_vec = []; e_vec = [];
        end_of_watch = timesteps*end_hour-1;
        wait_steps = 1; agent_acted = false;
        TD = []; cont_net = [];
    %==========================================================================    
end

timer = 0;
% initialize vectors and cells to save the results from energyplus
energy = zeros(length_sim+1,zone_number);
fanger = zeros(length_sim+1,zone_number);
tot_control = fanger;
%We want to trace the track of our flags, in order to evaluate the learning
%process.
resultsTotal = zeros(length_sim+1,4);
weather_file = zeros(length_sim+1,3);

for i=1:zone_number
    results{i} = zeros(length_sim+1,4);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Establish the socket connection
try
    sockfd = establishClientSocket('socket.cfg');
catch
    exit
end
if sockfd < 0
    fprintf('Error: Failed to obtain socket file descriptor. sockfd=%d.\n',sockfd);
    exit;
end
disp('Connected to socket successfully')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Loop for simulation time steps.
simulate=true;
while (simulate) 
    % Assign values to be exchanged.
    try
        [retVal, flaRea, simTimRea, eplus_receive ] = exchangeDoublesWithSocket(sockfd, flaWri, length(eplus_receive), simTimWri, eplus_send);
    catch ME1
        % exchangeDoublesWithSocket had an error. Terminate the connection
        disp(['Error: ', ME1.message])
        sendClientError(sockfd, -1);
        closeIPC(sockfd);
        rethrow(ME1);
    end
    % Check return flags
    if (flaRea == 1) % End of simulation 
        disp('Matlab received end of simulation flag from BCVTB. Exit simulation.');
        closeIPC(sockfd);
        simulate=false;
    end
    if (retVal < 0) % Error during data exchange
        fprintf('Error: exchangeDoublesWithSocket has return value %d', retVal);
        sendClientError(sockfd, -1);
        closeIPC(sockfd);
        simulate=false; 
    end
    if (flaRea > 1) % BCVTB requests termination due to an error.
        fprintf('Error: BCVTB requested termination of the simulation by sending %d\n       Exit simulation.', ...
            retVal);
        sendClientError(sockfd, -1);
        closeIPC(sockfd);
        simulate=false;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    % No flags have been found that require termination of the 
    % simulation. 
    % Having obtained u_k, we compute the new state x_k+1 = f(u_k)
    % This is the actual simulation of the client.
    if (simulate)
        message = [' (' num2str(timer/length_sim*100) '% complete)'];
        timer = timer+1;
        %change the number of occupants in the rooms
        eplus_send(setpeople) = people(counter_people,:);
        counter_people = counter_people + 1;

        % scaling solar radiation
        eplus_receive(3) = eplus_receive(3)*scaling_sol;
        
        for i=1:zone_number
            energy(time,i) = sum(eplus_receive(energy_cool(i))+eplus_receive(energy_heat(i)));
        end

        fang_real = eplus_receive(pmvs);
        fanger(time,:) = fang_real;
        
        % if time in simulation then send actions else hvac system off
        if(mod(floor((time-1)/timesteps),24)>=start_hour && mod(floor((time-1)/timesteps),24)<end_hour)
            if (hvac_type == 1)
                setpoints = actions(counter,:);
                tot_control(time,:) = setpoints;
                counter=counter+1;
            end
            if (hvac_type == 2)
                % hvac control actions
                % STILL stuck to original schedule!
                wait_steps = wait_steps-1;
                t_d = mod(time-1,24*timesteps);
                occ = people(counter_people+1,2);
                current_state = state_maker(eplus_receive, temps, hums, fang_real(2), occ(1));
                if wait_steps == 0
                    wait_steps = 2;
                    actions_possible = act_maker(current_state(5));
                    transition_manager;
                    columbus;
                    [setpoint_1, t_c, agent_acted, prediction] = dummy(e, message, net, current_state, actions_possible, go_constant, t_c);
                    buff = setpoint_1;
                else
                    setpoint_1 = buff;
                    agent_acted = false;
                end
                if (t_d == end_of_watch)
                    disp(['Gave last action of the day. t_d = ' num2str(t_d) message]);
                    t_c = 0;
                end
                %For now we only train the first zone's room...
                setpoints = [23 setpoint_1 23*ones(1,zone_number-2)];
                
                tot_control(time,:) = setpoints;
                if agent_acted
                    action_taken = setpoint_1;
                end
            end
            
            for i = 1:zone_number
                if (cooling_heating == 1)
                    eplus_send(coolings(i)) = setpoints(i);
                    eplus_send(heatings(i)) = 5;
                else
                    eplus_send(heatings(i)) = setpoints(i);
                    eplus_send(coolings(i)) = 40;
                end
            end
        else
            % time out of simulation just keep hvac off
            eplus_send(coolings)=40;
            eplus_send(heatings)=5;
        end

        %save results
        for i=1:zone_number
            results{i}(time,:) = [eplus_receive(temps(i)) eplus_receive(hums(i)) energy(time,i) fanger(time,i)];   %temp hum consumption fanger
        end

        %save weather data
        weather_file(time,:) = [eplus_receive(1) eplus_receive(2) eplus_receive(3)];
        
        %save total results
        totalConsumption = sum(energy(time,:));
        %totalEnergy = max(0,totalConsumption-eplus_receive(3)/scaling_sol*photovolt_gain);
        totalEnergy = totalConsumption-eplus_receive(3)/scaling_sol*photovolt_gain;
        %totalFanger = max(0,sum(fanger(time,:))/zone_number);
        totalFanger = sum(fanger(time,:))/zone_number;
        %as score (cost) we have a compination of PPD and Energy Consumption
        %totalScore = totalFanger/5*trade_off + totalEnergy/3000*(1-trade_off);
        totalScore = trade_off*totalConsumption/(zone_number*2000) + (1-trade_off)*(ones(size(totalFanger,1), size(totalFanger,2))-cos(pi/2*totalFanger));
        resultsTotal(time,:) = [totalConsumption totalEnergy totalFanger totalScore];

        % Advance simulation time
        time=time+1;
        simTimWri =simTimWri+delTim;
    end
end

% save results to csv files (shift 1 because bcvtb<->energyplus has one timestep delay)
for i=1:zone_number
    results{i} = results{i}(2:end,:);
end

weather_file = weather_file(2:end,:);

resultsTotal = resultsTotal(2:end,:);

controlTotal = tot_control(2:end,:);

save Results.mat results weather_file resultsTotal controlTotal;

if hvac_type == 2
    save RL_package.mat TB net full_trans episodes TD lambda_vec e_vec unmet_timesteps mf sf me se;
end

exit(0);