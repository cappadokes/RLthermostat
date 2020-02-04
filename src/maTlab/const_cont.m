function setpoint = const_cont(currtemp, currfang)

if currfang > 0
    if abs(currfang) < 0.75
        setpoint = currtemp-rand;
    else
        setpoint = currtemp-1;
    end
else
    if abs(currfang) < 0.75
        setpoint = currtemp+rand;
    else
        setpoint = currtemp+1;
    end
end