function [grandavg, error, grandavg_bl, error_bl, grandavg_bldiff, error_bldiff, ...
    grandavg_bldiff_tm, error_bldiff_tm, grandavg_tm, error_tm, leg_gp] = pool_bar_format(bar_data, Gp_Type, InjType);

ctz_ind=find(ismember(InjType,'CTZ'));
sal_ind=find(ismember(InjType,'Saline'));
ctzlow_ind=find(ismember(InjType,'CTZLOW'));
sallow_ind=find(ismember(InjType,'SALLOW'));

% replace infinite entries with NaN (needed for ratio or percent change)
bar_data(isinf(bar_data))=NaN;

%---------
%---------
% average over all days and all mice by grouping for CTZ, treating each 15
% minute block post-drug as a separate measurement
% standard error over number of mice * number of days * number of 15 minute blocks (5))
A2_ctz=squeeze(bar_data(ctz_ind,strcmp(Gp_Type,'A2')==1,:,2:6));
WT_ctz=squeeze(bar_data(ctz_ind,strcmp(Gp_Type,'WT')==1,:,2:6));
bar_ctz_A2avg=nanmean(A2_ctz(:));
bar_ctz_WTavg=nanmean(WT_ctz(:));
ste_ctz_A2=nanstd(A2_ctz(:))./sqrt(length(find(~isnan(A2_ctz(:))==1)));
ste_ctz_WT=nanstd(WT_ctz(:))./sqrt(length(find(~isnan(WT_ctz(:))==1)));

% average over all days and all mice by grouping for SAL, treating each 15
% minute block post-drug as a separate measurement
A2_sal=squeeze(bar_data(sal_ind,strcmp(Gp_Type,'A2')==1,:,2:6));
WT_sal=squeeze(bar_data(sal_ind,strcmp(Gp_Type,'WT')==1,:,2:6));
bar_sal_A2avg=nanmean(A2_sal(:));
bar_sal_WTavg=nanmean(WT_sal(:));
ste_sal_A2=nanstd(A2_sal(:))./sqrt(length(find(~isnan(A2_sal(:))==1)));
ste_sal_WT=nanstd(WT_sal(:))./sqrt(length(find(~isnan(WT_sal(:))==1)));

% average over all days and all mice by grouping for CTZLOW, treating each 15
% minute block post-drug as a separate measurement
A2_ctzl=squeeze(bar_data(ctzlow_ind,strcmp(Gp_Type,'A2')==1,:,2:6));
WT_ctzl=squeeze(bar_data(ctzlow_ind,strcmp(Gp_Type,'WT')==1,:,2:6));
bar_ctzl_A2avg=nanmean(A2_ctzl(:));
bar_ctzl_WTavg=nanmean(WT_ctzl(:));
ste_ctzl_A2=nanstd(A2_ctzl(:))./sqrt(length(find(~isnan(A2_ctzl(:))==1)));
ste_ctzl_WT=nanstd(WT_ctzl(:))./sqrt(length(find(~isnan(WT_ctzl(:))==1)));

% average over all days and all mice by grouping for SALLOW (recordings paired with low CTZ), 
% treating each 15
% minute block post-drug as a separate measurement
A2_sall=squeeze(bar_data(sallow_ind,strcmp(Gp_Type,'A2')==1,:,2:6));
WT_sall=squeeze(bar_data(sallow_ind,strcmp(Gp_Type,'WT')==1,:,2:6));
bar_sall_A2avg=nanmean(A2_sall(:));
bar_sall_WTavg=nanmean(WT_sall(:));
ste_sall_A2=nanstd(A2_sall(:))./sqrt(length(find(~isnan(A2_sall(:))==1)));
ste_sall_WT=nanstd(WT_sall(:))./sqrt(length(find(~isnan(WT_sall(:))==1)));


% ----------
% ----------

% average over all days and all mice by grouping for CTZ at baseline (note,
% this averages over only 1 15 minute block, not 5, so error will be
% higher)
A2_ctz_bl=squeeze(bar_data(ctz_ind,strcmp(Gp_Type,'A2')==1,:,1));
WT_ctz_bl=squeeze(bar_data(ctz_ind,strcmp(Gp_Type,'WT')==1,:,1));
bar_ctz_A2avg_bl=nanmean(A2_ctz_bl(:));
bar_ctz_WTavg_bl=nanmean(WT_ctz_bl(:));
ste_ctz_A2_bl=nanstd(A2_ctz_bl(:))./sqrt(length(find(~isnan(A2_ctz_bl(:))==1)));
ste_ctz_WT_bl=nanstd(WT_ctz_bl(:))./sqrt(length(find(~isnan(WT_ctz_bl(:))==1)));

% average over all days and all mice by grouping for SAL at baseline (note,
% this averages over only 1 15 minute block, not 5, so error will be
% higher)
A2_sal_bl=squeeze(bar_data(sal_ind,strcmp(Gp_Type,'A2')==1,:,1));
WT_sal_bl=squeeze(bar_data(sal_ind,strcmp(Gp_Type,'WT')==1,:,1));
bar_sal_A2avg_bl=nanmean(A2_sal_bl(:));
bar_sal_WTavg_bl=nanmean(WT_sal_bl(:));
ste_sal_A2_bl=nanstd(A2_sal_bl(:))./sqrt(length(find(~isnan(A2_sal_bl(:))==1)));
ste_sal_WT_bl=nanstd(WT_sal_bl(:))./sqrt(length(find(~isnan(WT_sal_bl(:))==1)));

% average over all days and all mice by grouping for CTZLOW at baseline (note,
% this averages over only 1 15 minute block, not 5, so error will be
% higher)
A2_ctzl_bl=squeeze(bar_data(ctzlow_ind,strcmp(Gp_Type,'A2')==1,:,1));
WT_ctzl_bl=squeeze(bar_data(ctzlow_ind,strcmp(Gp_Type,'WT')==1,:,1));
bar_ctzl_A2avg_bl=nanmean(A2_ctzl_bl(:));
bar_ctzl_WTavg_bl=nanmean(WT_ctzl_bl(:));
ste_ctzl_A2_bl=nanstd(A2_ctzl_bl(:))./sqrt(length(find(~isnan(A2_ctzl_bl(:))==1)));
ste_ctzl_WT_bl=nanstd(WT_ctzl_bl(:))./sqrt(length(find(~isnan(WT_ctzl_bl(:))==1)));

% average over all days and all mice by grouping for SAL at baseline (note,
% this averages over only 1 15 minute block, not 5, so error will be
% higher)
A2_sall_bl=squeeze(bar_data(sallow_ind,strcmp(Gp_Type,'A2')==1,:,1));
WT_sall_bl=squeeze(bar_data(sallow_ind,strcmp(Gp_Type,'WT')==1,:,1));
bar_sall_A2avg_bl=nanmean(A2_sall_bl(:));
bar_sall_WTavg_bl=nanmean(WT_sall_bl(:));
ste_sall_A2_bl=nanstd(A2_sall_bl(:))./sqrt(length(find(~isnan(A2_sall_bl(:))==1)));
ste_sall_WT_bl=nanstd(WT_sall_bl(:))./sqrt(length(find(~isnan(WT_sall_bl(:))==1)));



%---------
%---------

% average change from baseline over all days and all mice by grouping for CTZ, treating each 15
% minute block post-drug as a separate measurement
% standard error over number of mice * number of days * number of 15 minute blocks (5))
A2_ctz_bldiff=A2_ctz-repmat(A2_ctz_bl,1,1,5);
WT_ctz_bldiff=WT_ctz-repmat(WT_ctz_bl,1,1,5);
bar_ctz_A2avg_bldiff=nanmean(A2_ctz_bldiff(:));
bar_ctz_WTavg_bldiff=nanmean(WT_ctz_bldiff(:));
ste_ctz_A2_bldiff=nanstd(A2_ctz_bldiff(:))./sqrt(length(find(~isnan(A2_ctz_bldiff(:))==1)));
ste_ctz_WT_bldiff=nanstd(WT_ctz_bldiff(:))./sqrt(length(find(~isnan(WT_ctz_bldiff(:))==1)));

% average over all days and all mice by grouping for SAL, treating each 15
% minute block post-drug as a separate measurement
A2_sal_bldiff=A2_sal-repmat(A2_sal_bl,1,1,5);
WT_sal_bldiff=WT_sal-repmat(WT_sal_bl,1,1,5);
bar_sal_A2avg_bldiff=nanmean(A2_sal_bldiff(:));
bar_sal_WTavg_bldiff=nanmean(WT_sal_bldiff(:));
ste_sal_A2_bldiff=nanstd(A2_sal_bldiff(:))./sqrt(length(find(~isnan(A2_sal_bldiff(:))==1)));
ste_sal_WT_bldiff=nanstd(WT_sal_bldiff(:))./sqrt(length(find(~isnan(WT_sal_bldiff(:))==1)));

% average change from baseline over all days and all mice by grouping for CTZLOW, treating each 15
% minute block post-drug as a separate measurement
% standard error over number of mice * number of days * number of 15 minute blocks (5))
A2_ctzl_bldiff=A2_ctzl-repmat(A2_ctzl_bl,1,1,5);
WT_ctzl_bldiff=WT_ctzl-repmat(WT_ctzl_bl,1,1,5);
bar_ctzl_A2avg_bldiff=nanmean(A2_ctzl_bldiff(:));
bar_ctzl_WTavg_bldiff=nanmean(WT_ctzl_bldiff(:));
ste_ctzl_A2_bldiff=nanstd(A2_ctzl_bldiff(:))./sqrt(length(find(~isnan(A2_ctzl_bldiff(:))==1)));
ste_ctzl_WT_bldiff=nanstd(WT_ctzl_bldiff(:))./sqrt(length(find(~isnan(WT_ctzl_bldiff(:))==1)));

% average over all days and all mice by grouping for SAL, treating each 15
% minute block post-drug as a separate measurement
A2_sall_bldiff=A2_sal-repmat(A2_sall_bl,1,1,5);
WT_sall_bldiff=WT_sal-repmat(WT_sall_bl,1,1,5);
bar_sall_A2avg_bldiff=nanmean(A2_sall_bldiff(:));
bar_sall_WTavg_bldiff=nanmean(WT_sall_bldiff(:));
ste_sall_A2_bldiff=nanstd(A2_sall_bldiff(:))./sqrt(length(find(~isnan(A2_sall_bldiff(:))==1)));
ste_sall_WT_bldiff=nanstd(WT_sall_bldiff(:))./sqrt(length(find(~isnan(WT_sall_bldiff(:))==1)));

%-------------
%-------------
% take average separately in each 15 minute
% post-injection block including baseline
%----
% Calculate for saline, difference from basline over 15 min blocks post
% injection
%-----
% Shift dimensions to have a 6 X 5 matrix for baseline shift data
%-----

A2_ctz_15min=squeeze(bar_data(ctz_ind,strcmp(Gp_Type,'A2')==1,:,1:6));
WT_ctz_15min=squeeze(bar_data(ctz_ind,strcmp(Gp_Type,'WT')==1,:,1:6));

A2_ctz_15min_reshape=cat(1,squeeze(A2_ctz_15min(1,:,:)),squeeze(A2_ctz_15min(2,:,:)));
WT_ctz_15min_reshape=cat(1,squeeze(WT_ctz_15min(1,:,:)),squeeze(WT_ctz_15min(2,:,:)));

bar_ctz_A2avg_tm=nanmean(A2_ctz_15min_reshape);
bar_ctz_WTavg_tm=nanmean(WT_ctz_15min_reshape);

ste_ctz_A2_tm=nanstd(A2_ctz_15min_reshape)./sqrt(sum(~isnan(A2_ctz_15min_reshape),1));
ste_ctz_WT_tm=nanstd(WT_ctz_15min_reshape)./sqrt(sum(~isnan(WT_ctz_15min_reshape),1));

%-----
% Calculate for saline, difference from basline over 15 min blocks post
% injection
%-----

% Shift dimensions to have a 6 X 5 matrix for baseline shift data
A2_sal_15min=squeeze(bar_data(sal_ind,strcmp(Gp_Type,'A2')==1,:,1:6));
WT_sal_15min=squeeze(bar_data(sal_ind,strcmp(Gp_Type,'WT')==1,:,1:6));

A2_sal_15min_reshape=cat(1,squeeze(A2_sal_15min(1,:,:)),squeeze(A2_sal_15min(2,:,:)));
WT_sal_15min_reshape=cat(1,squeeze(WT_sal_15min(1,:,:)),squeeze(WT_sal_15min(2,:,:)));

bar_sal_A2avg_tm=nanmean(A2_sal_15min_reshape);
bar_sal_WTavg_tm=nanmean(WT_sal_15min_reshape);

ste_sal_A2_tm=nanstd(A2_sal_15min_reshape)./sqrt(sum(~isnan(A2_sal_15min_reshape),1));
ste_sal_WT_tm=nanstd(WT_sal_15min_reshape)./sqrt(sum(~isnan(WT_sal_15min_reshape),1));

%----
% Calculate for low ctz injection, difference from basline over 15 min blocks post
% injection
%-----

A2_ctzl_15min=squeeze(bar_data(ctzlow_ind,strcmp(Gp_Type,'A2')==1,:,1:6));
WT_ctzl_15min=squeeze(bar_data(ctzlow_ind,strcmp(Gp_Type,'WT')==1,:,1:6));

A2_ctzl_15min_reshape=cat(1,squeeze(A2_ctzl_15min(1,:,:)),squeeze(A2_ctzl_15min(2,:,:)));
WT_ctzl_15min_reshape=cat(1,squeeze(WT_ctzl_15min(1,:,:)),squeeze(WT_ctzl_15min(2,:,:)));

bar_ctzl_A2avg_tm=nanmean(A2_ctz_15min_reshape);
bar_ctzl_WTavg_tm=nanmean(WT_ctz_15min_reshape);

ste_ctzl_A2_tm=nanstd(A2_ctzl_15min_reshape)./sqrt(sum(~isnan(A2_ctzl_15min_reshape),1));
ste_ctzl_WT_tm=nanstd(WT_ctzl_15min_reshape)./sqrt(sum(~isnan(WT_ctzl_15min_reshape),1));

%-----
% Calculate for saline low, paired with half dose CTZ, difference from basline over 15 min blocks post
% injection
%-----

% Shift dimensions to have a 6 X 5 matrix for baseline shift data
A2_sall_15min=squeeze(bar_data(sallow_ind,strcmp(Gp_Type,'A2')==1,:,1:6));
WT_sall_15min=squeeze(bar_data(sallow_ind,strcmp(Gp_Type,'WT')==1,:,1:6));

A2_sall_15min_reshape=cat(1,squeeze(A2_sall_15min(1,:,:)),squeeze(A2_sall_15min(2,:,:)));
WT_sall_15min_reshape=cat(1,squeeze(WT_sall_15min(1,:,:)),squeeze(WT_sall_15min(2,:,:)));

bar_sall_A2avg_tm=nanmean(A2_sall_15min_reshape);
bar_sall_WTavg_tm=nanmean(WT_sall_15min_reshape);

ste_sall_A2_tm=nanstd(A2_sall_15min_reshape)./sqrt(sum(~isnan(A2_sall_15min_reshape),1));
ste_sall_WT_tm=nanstd(WT_sall_15min_reshape)./sqrt(sum(~isnan(WT_sall_15min_reshape),1));

%--------------
%--------------

%----
% for difference from baseline, take average separately in each 15 minute
% post-injection block
%----
% Calculate for ctz, difference from baseline over 15 min blocks post
% injection
%-----
% Shift dimensions to have a 6 X 5 matrix for baseline shift data
%-----
A2_ctz_bldiff_reshape=cat(1,squeeze(A2_ctz_bldiff(1,:,:)),squeeze(A2_ctz_bldiff(2,:,:)));
WT_ctz_bldiff_reshape=cat(1,squeeze(WT_ctz_bldiff(1,:,:)),squeeze(WT_ctz_bldiff(2,:,:)));
bar_ctz_A2avg_bldiff_tm=nanmean(A2_ctz_bldiff_reshape);
bar_ctz_WTavg_bldiff_tm=nanmean(WT_ctz_bldiff_reshape);
ste_ctz_A2_bldiff_tm=nanstd(A2_ctz_bldiff_reshape)./sqrt(sum(~isnan(A2_ctz_bldiff_reshape),1));
ste_ctz_WT_bldiff_tm=nanstd(WT_ctz_bldiff_reshape)./sqrt(sum(~isnan(WT_ctz_bldiff_reshape),1));

%-----
% Calculate for saline, difference from baseline over 15 min blocks post
% injection
%-----
% Shift dimensions to have a 6 X 5 matrix for baseline shift data
%-----
A2_sal_bldiff_reshape=cat(1,squeeze(A2_sal_bldiff(1,:,:)),squeeze(A2_sal_bldiff(2,:,:)));
WT_sal_bldiff_reshape=cat(1,squeeze(WT_sal_bldiff(1,:,:)),squeeze(WT_sal_bldiff(2,:,:)));
bar_sal_A2avg_bldiff_tm=nanmean(A2_sal_bldiff_reshape);
bar_sal_WTavg_bldiff_tm=nanmean(WT_sal_bldiff_reshape);
ste_sal_A2_bldiff_tm=nanstd(A2_sal_bldiff_reshape)./sqrt(sum(~isnan(A2_sal_bldiff_reshape),1));
ste_sal_WT_bldiff_tm=nanstd(WT_sal_bldiff_reshape)./sqrt(sum(~isnan(WT_sal_bldiff_reshape),1));

%----
% Calculate for low ctz, difference from baseline over 15 min blocks post
% injection
%-----
% Shift dimensions to have a 6 X 5 matrix for baseline shift data
%-----
A2_ctzl_bldiff_reshape=cat(1,squeeze(A2_ctzl_bldiff(1,:,:)),squeeze(A2_ctzl_bldiff(2,:,:)));
WT_ctzl_bldiff_reshape=cat(1,squeeze(WT_ctzl_bldiff(1,:,:)),squeeze(WT_ctzl_bldiff(2,:,:)));
bar_ctzl_A2avg_bldiff_tm=nanmean(A2_ctzl_bldiff_reshape);
bar_ctzl_WTavg_bldiff_tm=nanmean(WT_ctzl_bldiff_reshape);
ste_ctzl_A2_bldiff_tm=nanstd(A2_ctzl_bldiff_reshape)./sqrt(sum(~isnan(A2_ctzl_bldiff_reshape),1));
ste_ctzl_WT_bldiff_tm=nanstd(WT_ctzl_bldiff_reshape)./sqrt(sum(~isnan(WT_ctzl_bldiff_reshape),1));

%-----
% Calculate for saline, difference from baseline over 15 min blocks post
% injection
%-----
% Shift dimensions to have a 6 X 5 matrix for baseline shift data
%-----
A2_sall_bldiff_reshape=cat(1,squeeze(A2_sall_bldiff(1,:,:)),squeeze(A2_sall_bldiff(2,:,:)));
WT_sall_bldiff_reshape=cat(1,squeeze(WT_sall_bldiff(1,:,:)),squeeze(WT_sall_bldiff(2,:,:)));
bar_sall_A2avg_bldiff_tm=nanmean(A2_sall_bldiff_reshape);
bar_sall_WTavg_bldiff_tm=nanmean(WT_sall_bldiff_reshape);
ste_sall_A2_bldiff_tm=nanstd(A2_sall_bldiff_reshape)./sqrt(sum(~isnan(A2_sall_bldiff_reshape),1));
ste_sall_WT_bldiff_tm=nanstd(WT_sall_bldiff_reshape)./sqrt(sum(~isnan(WT_sall_bldiff_reshape),1));

%---------------
%Compile overall averages & errors into single vector or matrix for
%plotting
%---------------
grandavg=[bar_sal_WTavg bar_ctz_WTavg bar_sall_WTavg bar_ctzl_WTavg bar_sal_A2avg bar_ctz_A2avg bar_sall_A2avg bar_ctzl_A2avg];
error=[ste_sal_WT ste_ctz_WT ste_sall_WT ste_ctzl_WT ste_sal_A2 ste_ctz_A2 ste_sall_A2 ste_ctzl_A2];
grandavg_bl=[bar_sal_WTavg_bl bar_ctz_WTavg_bl bar_sall_WTavg_bl bar_ctzl_WTavg_bl bar_sal_A2avg_bl bar_ctz_A2avg_bl bar_sall_A2avg_bl bar_ctzl_A2avg_bl];
error_bl=[ste_sal_WT_bl ste_ctz_WT_bl ste_sall_WT_bl ste_ctzl_WT_bl ste_sal_A2_bl ste_ctz_A2_bl ste_sall_A2_bl ste_ctzl_A2_bl];
grandavg_bldiff=[bar_sal_WTavg_bldiff bar_ctz_WTavg_bldiff bar_sall_WTavg_bldiff bar_ctzl_WTavg_bldiff bar_sal_A2avg_bldiff bar_ctz_A2avg_bldiff bar_sall_A2avg_bldiff bar_ctzl_A2avg_bldiff];
error_bldiff=[ste_sal_WT_bldiff ste_ctz_WT_bldiff ste_sall_WT_bldiff ste_ctzl_WT_bldiff ste_sal_A2_bldiff ste_ctz_A2_bldiff ste_sall_A2_bldiff ste_ctzl_A2_bldiff];
grandavg_bldiff_tm=cat(1,bar_sal_WTavg_bldiff_tm, bar_ctz_WTavg_bldiff_tm, bar_sall_WTavg_bldiff_tm, bar_ctzl_WTavg_bldiff_tm, bar_sal_A2avg_bldiff_tm, bar_ctz_A2avg_bldiff_tm, bar_sall_A2avg_bldiff_tm, bar_ctzl_A2avg_bldiff_tm);
error_bldiff_tm=cat(1,ste_sal_WT_bldiff_tm, ste_ctz_WT_bldiff_tm, ste_sal_WT_bldiff_tm, ste_ctzl_WT_bldiff_tm, ste_sal_A2_bldiff_tm, ste_ctz_A2_bldiff_tm, ste_sal_A2_bldiff_tm, ste_ctzl_A2_bldiff_tm);
grandavg_tm=cat(1,bar_sal_WTavg_tm, bar_ctz_WTavg_tm, bar_sall_WTavg_tm, bar_ctzl_WTavg_tm, bar_sal_A2avg_tm, bar_ctz_A2avg_tm, bar_sall_A2avg_tm, bar_ctzl_A2avg_tm);
error_tm=cat(1,ste_sal_WT_tm, ste_ctz_WT_tm, ste_sall_WT_tm, ste_ctzl_WT_tm, ste_sal_A2_tm, ste_ctz_A2_tm, ste_sall_A2_tm, ste_ctzl_A2_tm);

leg_gp={'WT SAL';'WT CTZ'; 'WT SALL';'WT CTZL';'A2A SAL';'A2A CTZ'; 'A2A SALL' ;'A2A CTZL'};


