%This simple function labels the 'region' of a state, judging by the
%occupants' thermal comfort, represented by the fanger score that we assume
%can be computed anywhere and anytime.

function id = region_id(state)

fanger = state(4);

if abs(fanger) < 0.2
    id = 1;
elseif abs(fanger) < 0.5
    id = 3;
else
    id = 2;

end