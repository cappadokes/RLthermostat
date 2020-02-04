function locvec = morningfinder(stepseries)

locvec = [];
start_found = true;

for i = 1:length(stepseries)-1
    if start_found
        locvec = [locvec i];
        start_found = false;
    elseif stepseries(i+1) < stepseries(i)
        start_found = true;
    end
end

end