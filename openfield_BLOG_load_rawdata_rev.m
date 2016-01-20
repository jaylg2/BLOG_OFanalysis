clear all

% DataDir='../BLOGBehavior/B1OpenFieldDay1_2/';
% RawDataDir='../BLOGBehavior/B1OpenFieldDay1_2/RawData/';

DataDir='../BLOGBehavior/B1OpenFieldDay1_12/';
RawDataDir='../BLOGBehavior/B1OpenFieldDay1_12/';

% Identify raw data filenames
RawList=dir(RawDataDir);
RawList={RawList.name};
RawList={RawList{strmatch('Track',RawList)}};

myindices = find(~cellfun(@isempty,regexp(RawList,'Arena 1'))==1);

filename=[DataDir 'Statistics-NathanJay-BLOG-openfield.txt'];

%[alldata] = import_openfield_jay(filename, 11, 60);
[alldata] = import_etho_gen_v1(filename);

bad_trials=[1 2 3 16];
good_inds=find(~ismember(alldata.TrialNumber,bad_trials));

MouseTags=unique(alldata.EarTag);
for i=1:length(MouseTags)
    MouseInds{i}=intersect(find(strcmp(alldata.EarTag,MouseTags(i))==1),good_inds);
    Gp_Type{i}=alldata.MouseType{MouseInds{i}(1)}(1:2);
    Leg{i}=[Gp_Type{i} ' ' MouseTags(i)];
end

InjType=unique(alldata.InjectionType);
for i=1:length(InjType)
    InjInds{i}=intersect(find(ismember(alldata.InjectionType,InjType{i})==1),good_inds);
    for j=1:length(MouseTags);
        MouseInj{j}{i}=intersect(MouseInds{j},InjInds{i});
        for k=1:length(MouseInj{j}{i})
            tic
            [i j k]
            ind=MouseInj{j}{i}(k);
            RawFile{j}{i}{k}=RawList{find(~cellfun(@isempty,regexp(RawList,[num2str(alldata.TrialNumber(ind)) '-Arena ' num2str(alldata.Arena(ind))]))==1)};
            [RawData{j}{i}{k}]=openfield_loadsinglerawfile([RawDataDir RawFile{j}{i}{k}]);
            toc
        end
    end
end

%save([RawDataDir 'RawData_proc_D1_D2'],'RawFile','RawData','MouseInj','InjInds','InjType','good_inds','alldata','MouseTags','MouseInds')
save([RawDataDir 'RawData_proc_D1_D12'],'RawFile','RawData','MouseInj','InjInds','InjType','good_inds','alldata','MouseTags','MouseInds')






