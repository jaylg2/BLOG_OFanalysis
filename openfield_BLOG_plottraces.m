clear all

% DataDir='../BLOGBehavior/B1OpenFieldDay1_2/';
% RawDataDir='../BLOGBehavior/B1OpenFieldDay1_2/RawData/';
% 
% load([RawDataDir 'RawData_proc_D1_D2'],'RawFile','RawData','MouseInj','InjInds','InjType','good_inds','alldata','MouseTags','MouseInds')

DataDir='../BLOGBehavior/B1OpenFieldDay1_12/';
RawDataDir='../BLOGBehavior/B1OpenFieldDay1_12/';

load([RawDataDir 'RawData_proc_D1_D12'],'RawFile','RawData','MouseInj','InjInds','InjType','good_inds','alldata','MouseTags','MouseInds')

for i=1:length(InjType)
    figure
    plotind=1
    InjInds{i}=intersect(find(ismember(alldata.InjectionType,InjType{i})==1),good_inds);
    %for j=1:length(MouseTags);
    for j=4;    
        MouseInj{j}{i}=intersect(MouseInds{j},InjInds{i});
        for k=1:length(MouseInj{j}{i})
            subplot(4,6,plotind)
            plot(RawData{j}{i}{k}.xcent,RawData{j}{i}{k}.ycent)
            plotind=plotind+1;
            xlim([-60 60])
            ylim([-40 40])
        end
    end
end



