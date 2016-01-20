%--------
% Nathan VC
% 11/2015
%--------
% Plot several bar graphs based on summarized motor output in open field
% Needs to call openfield_BLOG_load and barformat in order to run
%--------

function pooledbarplot(form_data, MouseInjDay, title_tag, Gp_Type, InjType)

%------------------------
% calculate bar graph info
%-------------------------
bar_data=barformat_3(form_data, MouseInjDay);

[grandavg, error, grandavg_bl, error_bl, ...
    grandavg_bldiff, error_bldiff, grandavg_bldiff_tm, error_bldiff_tm, ... 
    grandavg_tm, error_tm, leg_gp] = pool_bar_format(bar_data, Gp_Type, InjType);

%-----------------
% Plot Averages over all mice in each group/day (per injection type)
%-----------------

figure
cmap=colormap('lines');
subplot(3,1,1)
for i=1:length(grandavg_bl)
    h(i)=bar(i,grandavg_bl(i),'facecolor',cmap(i,:));
    hold on
end
errorbar(grandavg_bl, error_bl,'k.');
title({title_tag; 'n=2 mice, d=3 days,' ; 'Baseline 15 min blocks'},'fontsize',15)
set(gca,'xtick',[1:8])
set(gca,'xticklabel',leg_gp)
%ylim([0 1000])

subplot(3,1,2)
for i=1:length(grandavg)
    h(i)=bar(i,grandavg(i),'facecolor',cmap(i,:));
    hold on
end
errorbar(grandavg, error,'k.');
title('Avg over 5 15 min blocks post-inj ','fontsize',15)
set(gca,'xtick',[1:8])
set(gca,'xticklabel',leg_gp)
%ylim([0 1000])

subplot(3,1,3)
for i=1:length(grandavg_bldiff)
    h(i)=bar(i,grandavg_bldiff(i),'facecolor',cmap(i,:));
    hold on
end
errorbar(grandavg_bldiff, error_bldiff,'k.');
title('Change from baseline, avg 5 15 min blocks','fontsize',18)
set(gca,'xtick',[1:8])
set(gca,'xticklabel',leg_gp)
%ylim([-350 0])

% ----------
% Plot averaging across mice/days in each 15 minute bin
% -----------

figure

subplot(2,1,1)
barwitherr(error_tm,grandavg_tm)
set(gca,'xticklabel',1:8)
set(gca,'xticklabel',leg_gp)
title([title_tag ' by 15 min bins'],'fontsize',18)

%colormap(lines)
subplot(2,1,2)
%colormap(lines)
barwitherr(error_bldiff_tm,grandavg_bldiff_tm)
set(gca,'xticklabel',1:8)
set(gca,'xticklabel',leg_gp)
title('Change from Baseline, 15 min bins','fontsize',18)



