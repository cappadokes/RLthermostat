%========================================================================
%|National Technical University of Athens                               |
%|School of Electrical & Computer Engineering                           |
%|Microprocessors & Digital Systems Lab                                 |
%|----------------------------------------------------------------------|
%|"Realization of an Energy Management System for Commercial Buildings" |
%|Undergraduate Thesis                                                  |
%========================================================================

%The following script initializes the simulation parameters that are
%going to be used by the starSimulation script. It is for now assumed that
%the environment is a 10-zone building.

%First, the user chooses the type of HVAC control.
prompt = 'HVAC [1/2/3: Random Setpoints/NFQ/Constant Setpoints]: ';
hvac_choice = input(prompt);
while (hvac_choice ~= 1) && (hvac_choice ~= 2) && (hvac_choice ~= 3)
   disp('Wrong input. Please try again.');
   hvac_choice = input(prompt); 
end

if hvac_choice == 3
    prompt = 'Please insert constant setpoint: ';
    cs = input(prompt);
end

%Then, the user chooses the starting day of the simulation to follow.
prompt = 'First day [0,365]: ';
start_day = input(prompt);
while (start_day < 0) || (start_day > 365)
   disp('Wrong input. Please try again.');
   start_day = input(prompt); 
end

%Now it's time for the ending day of the simulation...
prompt = 'Last day [0,365]: ';
end_day = input(prompt);
while (end_day < 0) || (end_day > 365) || (end_day < start_day)
   disp('Wrong input. Please try again.');
   end_day = input(prompt); 
end

%Then, the user chooses the starting hour.
prompt = 'Start hour [0,24]: ';
start_hour = input(prompt);
while (start_hour < 0) || (start_hour > 24)
   disp('Wrong input. Please try again.');
   start_day = input(prompt); 
end

%Ending hour...
prompt = 'End hour [0,24]: ';
end_hour = input(prompt);
while (end_hour < 0) || (end_hour > 24) || (end_hour <= start_hour)
   disp('Wrong input. Please try again.');
   end_day = input(prompt); 
end

%Timestep size. The thermostat will change its setpoint according to the
%control law every x minutes, depending on the user's choice.
prompt = 'Control timestep [10,20,30,60]: ';
x = input(prompt);
while (x ~= 20) && (x ~= 60) && (x ~= 30) && (x ~= 10)
   disp('Wrong input. Please try again.');
   x = input(prompt); 
end
timesteps = 60/x;

%We differentiate between the length of the control (only between start_hour and end_hour)
%and the total length of the simulation.
length_control = (end_day-start_day+1)*(end_hour-start_hour)*timesteps;
length_sim = (end_day-start_day+1)*24*timesteps;

if (hvac_choice == 1) || (hvac_choice == 3)
    if (hvac_choice == 1)
        actions = randi([15,30],length_control+1,10);
    else
        actions = cs.*ones(length_control+1,10);
    end
    save Actions.mat actions;
    hvac_type = 1;
else
    hvac_type = 2;
end

%Finally, the user can choose whether there is a constant or random number
%of occupants in each room

%Occupants:
prompt = 'Occupancy [1/2: Constant/Random]: ';
occupants = input(prompt);
while (occupants ~= 1) && (occupants ~= 2)
   disp('Wrong input. Please try again.');
   occupants = input(prompt); 
end

if occupants == 1
    prompt = 'Please insert constant occupants number: ';
    cs = input(prompt);
    people = cs*ones(length_sim+1,10);
    save people.mat people;
end

clear cs prompt people actions x;