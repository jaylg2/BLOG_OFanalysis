% 11/2015
% NathanVC
%----------
% Loads ethovision open field output for initial BLOG experiment
% Generates structures that contain trial number for each mouse and
% injection type
%----------
% Called by BLOG_barplot to plot bar graph summaries of various output
% measures
%----------
% Note that ethovision output sometimes randomly changes order of outputs, 
% so the importing command may need to be changed for future imports
% The one used here "import_thoe_gen_v1" is made to work with any order of
% columns from version 8.5, but it's possible I missed something and it may
% require future debugging
% ----------

clear all

%DataDir='data/B1OpenFieldDay1_11/';
DataDir='data/B1OpenFieldDay1_12/';

filename=[DataDir 'Statistics-NathanJay-BLOG-openfield.txt'];

%[alldata]=import_etho_gen_v1(filename);
[alldata]=import_etho_gen_v1(filename);

% consider only indices of "good" trials (where there was an actual mouse...)
bad_trials=[1 2 3 16 89 ];
good_inds=find(~ismember(alldata.TrialNumber,bad_trials));

% Make structure with the trial numbers for each mouse
MouseTags=unique({alldata.EarTag{good_inds}});
for m=1:length(MouseTags)
    % Find index in alldata for all trials run by a particular mouse
    MouseInds{m}=find(strcmp(alldata.EarTag,MouseTags(m))==1);
    
    % Make legend entry string, that has group type and mouse tag number
    Gp_Type{m}=alldata.MouseType{MouseInds{m}(1)}(1:2);
    Leg{m}=strjoin([Gp_Type{m} MouseTags(m)]);
end

% Cell containing all injection typesInjType=unique(alldata.InjectionType);
InjType=unique({alldata.InjectionType{good_inds}});

% Identify all dates mice are run, put them in order, and find trial
% indexes for each day to use later
AllDates=unique({alldata.Date{good_inds}}); %NOTE be careful, if we enter dates in inconsistent format this will accidentally create new days...
AllDates=reorder_dates(AllDates); % reordering days to be in chronological order

for d=1:length(AllDates)
    % find all trials run on a particular day
    DateInds{d}=find(ismember(alldata.Date,AllDates{d})==1);
    for i=1:length(InjType)
        % Make cell that organizes by injection type and date
        DateInjInds{i}{d}=intersect(find(ismember(alldata.InjectionType,InjType{i})==1),DateInds{d});
        % Matrix indicating which dates to include for each injection type
        % For each injection type, this gives an entry of 1 or zero for
        % each date to indicate whether that injeciton was given on that
        % day, later find only the ones
        DateInjMat{i}(d)=~isempty(DateInjInds{i}{d});
    end
end 

for i=1:length(InjType)
    % index of dates to include for each injection type
    DateInjMat{i}=find(DateInjMat{i}==1);
    % Strings that indicate actual date, useful for plots
    for d=1:length(DateInjMat{i})
        DateInjStr{i}{d}=AllDates{DateInjMat{i}(d)};
    end
end

% Make structure with the trial numbers for each injection type, mouse &
% day, for each injection type, day loops only through dates that
% particular injection was given
for i=1:length(InjType)
    InjInds{i}=intersect(find(ismember(alldata.InjectionType,InjType{i})==1),good_inds);
    for m=1:length(MouseTags);
        MouseInj{i}{m}=intersect(MouseInds{m},InjInds{i});
        %for d=1:length(AllDates)
        for d=1:length(DateInjMat{i})
            % Exclude particular mouse/day -- creates empty entries
            % here excluding mouse 818 on 12/11/15 because tracking was off at baseline 
            % We can retrack this
            if (strcmp(MouseTags{m},'818') && strcmp(AllDates(DateInjMat{i}(d)),'12/11/15'))
                MouseInjDay{i}{m}{d}=[];
            else
            MouseInjDay{i}{m}{d}=intersect(MouseInj{i}{m},DateInds{DateInjMat{i}(d)});
            end
        end    
    end
end

