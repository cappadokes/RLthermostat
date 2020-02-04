function writeSystemXML(filename,timestep,duration)

fid = fopen(['/home/clab/Desktop/thesis/sims/v13_NFQ_SEMI_FINAL/',filename],'r');
if (fid < 0)
    fprintf('Error reading idf file \n')
end
line1 = '';
line2 = '';
newline1 = '';
newline2 = '';
% Find the line to change
while ~feof(fid)
    line = fgetl(fid);
    if (line < 0)
        fprintf('Error reading idf file \n')
        break;
    end
    temp = strread(line,'%s','delimiter','=');
    if ~(isempty(temp))
        if (length(temp)>1)
            if strcmp(temp(2),'"timeStep" class')
                line1 = line;
                newline1 = strrep(line1,temp{4},strcat('"',int2str(60/timestep),'*60">'));
            end
            if strcmp(temp(2),'"endTime" class')
                line2 = line;
                newline2 = strrep(line2,temp{4},strcat('"',int2str(duration),'*24*3600">'));
                break;
            end
        end
    end
end
frewind(fid); % Go back to the beggining
fulltext = fread(fid,'*char')'; % Grab entire text
fclose(fid);
fid = fopen(['/home/clab/Desktop/thesis/sims/v13_NFQ_SEMI_FINAL/',filename],'w'); % Open again for writing
fulltext = strrep(fulltext,line1,newline1); % Replace line
fulltext = strrep(fulltext,line2,newline2); % Replace line
fprintf(fid,'%s',fulltext); % Write modified text
fclose(fid);

end
