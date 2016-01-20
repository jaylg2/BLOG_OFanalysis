% Nathan VC
% 11/2015
% --------
% function to format particular data based on indices indexed
% along 2 dimensions in a cell
% for the bioluminescence data 11/15 the first dimension is mouse number
% and the 2nd dimension is injection type
% Output is a single matrix with dimensions (mouse, injection group,
% trial#) that can be used to plot a bar graphs along certain dimensions
%-----------

% output bar graph data

function bar_data=barformat_3(data_in,index_cell)

injcount=length(index_cell);
mousecount=length(index_cell{1});

% Find maximum number of trials on any given day
maxcount=0;
for i=1:injcount
    for m=1:mousecount
        daycount_indiv(i,m)=length(index_cell{i}{m});
        for d=1:length(index_cell{i}{m})
             maxcount=max([maxcount length(index_cell{i}{m}{d})]);
        end
    end
end

daycount=max(daycount_indiv(:));
%maxcount=maxcount_indiv(:);

bar_data=nan(injcount, mousecount, daycount, maxcount);
            
% for BLOG data, this loops through mice
% loops through injection type
for i=1:injcount
    % loop through mice
    for m=1:mousecount
        % loops through trials -- this step can probably be vectorized but
        % I didn't bother
        % for d=1:daycount
        for d=1:length(index_cell{i}{m})  
            % loops through days
            if ~isempty(index_cell{i}{m}{d})
                for s=1:length(index_cell{i}{m}{d})
                    bar_data(i,m,d,s)=data_in(index_cell{i}{m}{d}(s));
                end
            end            
        end
    end
end

end
