function startSimulation(hvac_type, start_day, end_day, start_hour, end_hour, timesteps, zone_number, trade_off, occupants, photovolt_gain)
%%%	startSimulation : Starting Simulation of Hania Building in EnergyPlus %%%
%
%	Initializes the parameters for the simulation
%
%	Inputs:
%	input1 : hvac - select type for hvac control 1 for pre-load all actions from ./input/Actions.csv file (random or constant setpoints), 2 for deciding actions during simulation
%	input2 : start_day - The day of the year to start the simulation - [0,365]
%	input3 : end_day - The day of the year that the simulation ends - [0,365] >= start_day
%	input4 : start_hour - The hour of the start_day that the simulation begins - [0,24]
%	input5 : end_hour - The hour of the end_day that the simulation ends - [0,24]
%	input6 : timesteps - Number of timesteps per hour for reporting results or for controling HVAC system
%	input7 : zone_number - The number of building's thermal zones
%	input8 : trade_off - The trade_off between energy and fanger(Predicted Percentage of Dissatisfied) for reporting totalscore
%	input9 : occupants - 0 for not taking people into account, 1 for pre-loading people number for all timesteps by ./input/People.csv, 2 for random people number
%	input10 : photovolt_gain - The gain of photovoltaic systems
%
%	Outputs:
%	'Results(1-zone_number).csv' (for every room) files in './input' directory with [temperature humidity energy_consumption fanger] for every timestep
%	'TotalResults.csv' in './input' directory with [totalConsumption totalEnergy totalFanger totalScore] for every timestep
%					
%
%	
	% scaling parameters for humidity and solar radiation
	scaling_hum = 2000;
	scaling_sol = 0.05;
	
	% save parameters for using in other functions
	save parameters.mat;
	% calculate date for using in energyplus
	month_num = [31 59 90 120 151 181 212 243 273 304 334 365];
	month1 = 1;
	while (start_day > month_num(month1))
		month1 = month1+1;
	end
	if month1>1
		day1 = start_day - month_num(month1-1);
	else
		day1 = start_day;
	end
	month2 = 12;
	while (end_day <= month_num(month2-1))
		month2 = month2-1;
		if (month2 == 1)
			break;
		end
	end
	if month2>1
		day2 = end_day - month_num(month2-1);
	else
		day2 = end_day;
	end
	length_sim = (end_day-start_day+1)*24*timesteps;
	if occupants == 0 
		people = ones(length_sim+1,zone_number);
	elseif occupants == 1
        % people schedule loaded from mat file
        load people.mat
        people(end+1,:) =  people(end,:);
	else
		%people = floor(1+15*rand(length_sim+1,zone_number));
        max_num = 5;
        time = 1:(length_sim+1);
        in_day = false;
        start_idxs = find(mod(time,24*timesteps) == start_hour*timesteps);
        end_idxs = find(mod(time,24*timesteps) == end_hour*timesteps);
        for i = 1:length_sim+1
            if in_day
                people(i) = occupancy_func(people(i-1), max_num);
            else
                people(i) = 1;
            end
            if ismember(i,start_idxs)
                in_day = true;
            end
            if ismember(i, end_idxs)
                in_day = false;
            end
        end
        people = repmat(people, zone_number, 1)';
	end
	% save people number
	save people.mat people;
	% write idf with the updated parameters
	write_idf(timesteps,month1,day1,month2,day2);
	% write system.xml with the updated parameters
	writeSystemXML('system.xml',timesteps, end_day - start_day + 1);
	if hvac_type == 1	
		% load actions from mat file
		load Actions.mat;
		actions(end+1,:) =  actions(end,:);
		% save actions
		save Actions.mat actions;
		% excecute bcvtb for connecting matlab and EnergyPlus
		command = 'java -jar /home/clab/Desktop/thesis/sims/bcvtb/bin/BCVTB.jar -console /home/clab/Desktop/thesis/sims/v13_NFQ_SEMI_FINAL/system.xml';
		system(command);
    else        	%our control
		% excecute bcvtb for connecting matlab and EnergyPlus
		command = 'java -jar /home/clab/Desktop/thesis/sims/bcvtb/bin/BCVTB.jar -console /home/clab/Desktop/thesis/sims/v13_NFQ_SEMI_FINAL/system.xml';
		system(command);
	end
end
