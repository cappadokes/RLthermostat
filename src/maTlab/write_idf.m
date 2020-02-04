function write_idf(timestep,start_month,start_day,end_month,end_day)

fid = fopen('/home/clab/Desktop/thesis/sims/v13_NFQ_SEMI_FINAL/building/ePlus/building.idf','r');
if (fid < 0)
    fprintf('Error reading idf file \n')
end
line1 = '';
line2 = '';
line3 = '';
line4 = '';
line5 = '';
newline1 = '';
newline2 = '';
newline3 = '';
newline4 = '';
newline5 = '';
% Find the line to change
while not(feof(fid))
    line = fgetl(fid);
    if (line < 0)
    	fprintf('Error reading idf file \n')
    	break;
    end
    temp = strread(line,'%s','delimiter','!-');
    if ~(isempty(temp))
    	if strcmp(temp(end),'Number of Timesteps per Hour')
	        line1 = line;
	        newline1 = strrep(line,temp{1},['Timestep,',int2str(timestep),';']); %the new line
	    end
	    if strcmp(temp(end),'Begin Month')
	        line2 = line;
	        newline2 = strrep(line,temp{1},strcat(int2str(start_month),',')); %the new line
	    end
	    if strcmp(temp(end),'Begin Day of Month')
	    	line3 = line;
	    	newline3 = strrep(line,temp{1},strcat(int2str(start_day),','));
	    end
	    if strcmp(temp(end),'End Month')
	    	line4 = line;
	    	newline4 = strrep(line,temp{1},strcat(int2str(end_month),','));
	    end
	    if strcmp(temp(end),'End Day of Month')
	    	line5 = line;
	    	newline5 = strrep(line,temp{1},strcat(int2str(end_day),','));
	    	break;
	    end
	end
end
frewind(fid); % Go back to the beggining
fulltext = fread(fid,'*char')'; % Grab entire text
fclose(fid);
fid = fopen('/home/clab/Desktop/thesis/sims/v13_NFQ_SEMI_FINAL/building/ePlus/building.idf','w'); % Open again for writing
fulltext = strrep(fulltext,line1,newline1); % Replace line
fulltext = strrep(fulltext,line2,newline2); % Replace line
fulltext = strrep(fulltext,line3,newline3); % Replace line
fulltext = strrep(fulltext,line4,newline4); % Replace line
fulltext = strrep(fulltext,line5,newline5); % Replace line
fprintf(fid,'%s',fulltext); % Write modified text
fclose(fid);

end
