% script to reorder dates in chronological order
% dates of format m/d/year, with no place holding zeros
% input is cell array of strings
%---------
% Nathan VC
%---------
% 12/15/15

function [AllDates_ro]=reorder_dates(AllDates);

for i=1:length(AllDates)
    tempsplit=strsplit(AllDates{i},'/');
    % rescale to roughly a total day count since year zero (this is kind of silly but it
    % works)
    daycnt(i)=30.4167*str2num(tempsplit{1})+str2num(tempsplit{2})+365*str2num(tempsplit{3});
end

% reorder the approximate day count, where "reord" is the new index order
[~,reord]=sort(daycnt);

% output the reordered dates
AllDates_ro=AllDates(reord);
