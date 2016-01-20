function [alldata] = import_etho_gen_v1(filename, startRow, endRow)
%[alldata, HeaderFormat, dataArray, DataID]


% Import ethovision output open field data
% -----
% Nathan VC
% -----
% 11/2015
% -----
% Should work no matter the output order from ethovision
% Add fields to DataID if need to load a different column from ethovision
% Disregards any fields not in the DataID cell
% If want to skip initial rows, you can use startRow, but for reasons I
% can't quite pin down, the start needs to be 1 more than count from first
% real data row in input file
% -----

% Initialize variables.
delimiter = ';';
if nargin<=2
    startRow = 1;
    endRow = inf;
end

% Read columns of data as strings:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';

% Open the text file.
fileID = fopen(filename,'r');

% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.

dataArrayHeader = textscan(fileID, formatSpec, 4, 'Delimiter', delimiter);
for c=1:length(dataArrayHeader)
     for k=1:4
         %if d
         dataArrayHeader{c}(k)=clipquotes(dataArrayHeader{c}(k));
     end
     % remove garbage entries
     rmv=find(strcmp(dataArrayHeader{c},'Independent Variable')==1);
     dataArrayHeader{c}(rmv)='';
     
     rmv2=find(strcmp(dataArrayHeader{c},'<User-defined 1>')==1);
     dataArrayHeader{c}(rmv2)='';

     HeaderFormat{c}=strjoin(dataArrayHeader{c});
end
     
HeaderFormat=clipspace(HeaderFormat);

dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end



% 
% % Close the text file.
% fclose(fileID);
% 
% %define fields to load by header format, this will make it so we don't have
% %to rewrite our loading file whenever ethovision decides to change the
% %order of columns on output
% %-----
% % inputfield is the category label in the ethovision data
% % outfield is the field name in our reformatted data structure
% % .num indicates string or numberic content -- 1 for number 0 for string
% 
DataID{1}.inputfield='';
DataID{1}.outfield='TrialNumber';
DataID{1}.num=1;
% DataID{1}.index=2; %always index 2, no header label
% 
DataID{2}.inputfield='';
DataID{2}.outfield='Arena';
DataID{2}.num=1;
% DataID{2}.index=3; % always index 3, no header label

DataID{3}.inputfield='AnimalID';
DataID{3}.outfield='EarTag';
DataID{3}.num=0;  % indicator of string or numeric content

DataID{4}.inputfield='Dayoftest';
DataID{4}.outfield='Date';
DataID{4}.num=0;

DataID{5}.inputfield='InjectionGroup';
DataID{5}.outfield='InjectionType';
DataID{5}.num=0;

DataID{6}.inputfield='MouseType';
DataID{6}.outfield='MouseType';
DataID{6}.num=0;

DataID{7}.inputfield='Timeoftrial';
DataID{7}.outfield='TrialTime';
DataID{7}.num=0;

DataID{8}.inputfield='VelocityCenter-pointMeancm/s';
DataID{8}.outfield='Velocity';
DataID{8}.num=1;

DataID{9}.inputfield='DistancemovedCenter-pointTotalcm';
DataID{9}.outfield='Distance_total';
DataID{9}.num=1;

DataID{10}.inputfield='MovementCenter-point/MovingDurations';
DataID{10}.outfield='Movement_Duration';
DataID{10}.num=1;

%clockwise
DataID{11}.inputfield='RotationCenter-pointFrequency';
DataID{11}.outfield='Rotation_Clock';
DataID{11}.num=1;

%counter clockwise
DataID{12}.inputfield='Rotation2Center-pointFrequency';
DataID{12}.outfield='Rotation_CounterClock';
DataID{12}.num=1;

for j=3:length(DataID)
    DataID{j}.index=find(strcmp(HeaderFormat,DataID{j}.inputfield)==1);
end

for j=1
    find_trial_ind=zeros(1,length(dataArray));
    for k=1:length(dataArray)
        incval=strfind(dataArray{k}{1},'Trial');
        if ~isempty(incval)
            find_trial_ind(k)=incval;
        end
        DataID{j}.index=find(find_trial_ind>0);
    end
end

for j=2
    find_trial_ind=zeros(1,length(dataArray));
    for k=1:length(dataArray)
        incval=strfind(dataArray{k}{1},'Arena');
        if ~isempty(incval)
            find_trial_ind(k)=incval;
        end
        DataID{j}.index=find(find_trial_ind>0);
    end
end

%--------

% Load trial number
for k=1
    alldata.(DataID{k}.outfield)=cell2mat(cellfun(@str2num,cliptrial(clipquotes(dataArray{DataID{k}.index})),'UniformOutput',0));    
end

% Load Arena number
for k=2
    alldata.(DataID{k}.outfield)=cell2mat(cellfun(@str2num,cliparena(clipquotes(dataArray{DataID{k}.index})),'UniformOutput',0));    
end

for k=3:length(DataID)
   if DataID{k}.num==1;
        alldata.(DataID{k}.outfield)=cell2mat(cellfun(@str2num,clipquotes(dataArray{DataID{k}.index}),'UniformOutput',0));
   
   elseif DataID{k}.num==0;
        alldata.(DataID{k}.outfield)=clipquotes(dataArray{DataID{k}.index});
   end
   
end

% Functions for cleaning up strings inside cells
%---------

end

function [rev_cell]=clipquotes(inp_cell)
for i=1:length(inp_cell)
       A=strfind(inp_cell{i},'"');
       inp_cell{i}(A)=[];
       rev_cell=inp_cell;
end
end

function [rev_cell]=clipspace(inp_cell)
for i=1:length(inp_cell)
       A=strfind(inp_cell{i},' ');
       inp_cell{i}(A)=[];
       rev_cell=inp_cell;
end
end


function [rev_cell]=cliptrial(inp_cell)
for i=1:length(inp_cell)
    if ~isempty(inp_cell{i})
        A=strfind(inp_cell{i},'Trial');
        inp_cell{i}(A:A+4)=[];
        rev_cell=inp_cell;
    end
end
end

function [rev_cell]=cliparena(inp_cell)
for i=1:length(inp_cell)
    if ~isempty(inp_cell{i})
        A=strfind(inp_cell{i},'Arena');
        inp_cell{i}(A:A+4)=[];
        rev_cell=inp_cell;
    end
end
end
