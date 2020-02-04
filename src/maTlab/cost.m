function totalscore = cost(x)
%%%	cost: Total score of the building with specific HVAC actions
%
%	Calculates the score in x actions to use with fmincon for the best solution in startSimulation.m
%
%	Input:
%	input1 : x - hvac setpoints for the building
%
%	Output:
%	output1: score - the total score for the input actions
%
%
	load('./parameters/PARAMETERS.mat','zone_number')
	actions = [x];
	for (i=1:zone_number-1)
		actions = [actions; x];
	end
	actions = actions';
	save('./input/Actions.mat','actions');
	command = ['java -jar /usr/local/bcvtb/bcvtb_v1.6/bin/BCVTB.jar -console ../system.xml'];
	system(command);
	load('./results/TotalScore.mat','score');
	totalscore = sum(score);
	load('./fmincon/costs.mat','costs');
	if totalscore < min(costs)
		save('./fmincon/Actions.mat','actions');
	end
	costs = [costs; totalscore];
	save('./fmincon/costs.mat','costs');
end