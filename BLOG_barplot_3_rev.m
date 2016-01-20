% Nathan VC
% 11/2015
%--------
% Plot several bar graphs based on summarized motor output in open field
% Needs to call openfield_BLOG_load and barformat in order to run
%--------

% Load data and make index structures
openfield_BLOG_load

% Plot Movement outputs
pooledbarplot(alldata.Movement_Duration, MouseInjDay, 'Movement', Gp_Type, InjType)

pooledbarplot(alldata.Velocity, MouseInjDay, 'Velocity', Gp_Type, InjType)

pooledbarplot(alldata.Distance_total, MouseInjDay, 'Distance', Gp_Type, InjType)

% Plot rotation counts
pooledbarplot(alldata.Rotation_Clock, MouseInjDay, 'Clockwise', Gp_Type, InjType)

pooledbarplot(alldata.Rotation_CounterClock, MouseInjDay, 'Counter Clockwise', Gp_Type, InjType)

% Plot rotation count ratios (note that inf ratios are disregarded)
pooledbarplot(alldata.Rotation_Clock./alldata.Rotation_CounterClock, MouseInjDay, 'Clock:CounterClock', Gp_Type, InjType)
