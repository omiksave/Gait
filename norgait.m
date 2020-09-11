function [mean_curv,dev_plot] = norgait(data,frame,int,ylab,tit)
%NORGAIT is a function that generates two (gait) normalized figures of the given signal:
% 
%*Mean signal and +/- 1 standard deviation.
% 
%*Mean and all signal cycles.
%See also DYNA
%
%Usage:
%[mean,dev] = norgait(data,frame,int,tit);
%
%mean - normalized (amplitude 0 at 0% gait cycle) mean of input signal.
% 
%dev - array of size nx2. dev(1) holds mean + 1 standard deviation and dev(2) holds mean + 1 standard deviation
% 
%data - vector consisting of data to be gait normalized and plotted.
% 
%frame - vector consisting of heel-strikes.
%See also GAITPHASE.
% 
%int - 1(enable). 1 enables toe-strike, heel-off and toe-off indication. Skip to disable.
% 
%ylab - Label of y axis of the plot. X axis is 'Gait Cycle (%)'. If unsure skip.
%
%title - Title of the plot. Legends only indicate the mean curve. If unsure skip.

tic;
if ~exist('int','var')
    int = 0;
end
if ~exist('ylab','var')
    ylab = [];
end
if ~exist('tit','var')
    tit = [];
end
range = abs(diff(frame));%Count sample range for heelstrike
max_sample = max(range)+1;%Cycle with most number of points
min_sample = min(range)+1;%Cycle with most number of points
clearvars i
% Normalize gait cycle to percentage (0 - 100)
strike_factor = zeros(length(range),1);
sample = zeros(length(range),1);
for i=1:length(range)
    strike_factor(i,1) = 100/(range(i));
    sample(i,1) = range(i)+1;
end
clearvars i
%Resample all deficient gait cycles
resamp = zeros(max_sample,length(range));
for i = 1:length(range)
    if sample(i) ~= max_sample
        resamp(:,i) = resample(data(frame(i):frame(i+1)),max_sample,sample(i));
       
    else
        resamp(:,i) = data(frame(i):frame(i+1));
        %x_i = i;
    end
end
%Find mean of all gait cycles
clearvars i
mean_curv = zeros(size(resamp,1),1);
std_dev = zeros(size(resamp,1),1);
dev_plot = zeros(size(resamp,1),2);
for i = 1:size(resamp,1)
    mean_curv(i,1) = mean(resamp(i,:));   % Mean of all points on Gait Cycle
    std_dev(i,1) = std(resamp(i,:));      % Standard Deviation of all points
    dev_plot(i,1) = mean_curv(i)+std_dev(i); % +1 Standard Deviation
    dev_plot(i,2) = mean_curv(i)-std_dev(i); % -1 Standard Deviation
end
%Plot Mean and Standard Deviation of Gait Cycle
figure
p1 = plot(0:100/(length(mean_curv)-1):100,mean_curv,'Color','r','LineWidth',1.2);
hold on
p2 = plot(0:100/(length(dev_plot)-1):100,dev_plot(:,1),'LineStyle','--','Color','k');
p3 = plot(0:100/(length(dev_plot)-1):100,dev_plot(:,2),'LineStyle','--','Color','k');
if int==1
    toe_strike = find(mean_curv == min(mean_curv(1:round(0.2*length(mean_curv)))));
    heel_off = find(mean_curv == max(mean_curv(toe_strike:round(0.55*length(mean_curv)))));
    toe_off = find(mean_curv == min(mean_curv(heel_off:round(0.75*length(mean_curv)))));
    p3 = plot((heel_off/length(mean_curv))*100,mean_curv(heel_off),'o','MarkerSize',10,'MarkerFaceColor','b','MarkerEdgeColor','k');
    p4 = plot((toe_off/length(mean_curv))*100,mean_curv(toe_off),'o','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','k');
    p5 = plot((toe_strike/length(mean_curv))*100,mean_curv(toe_strike),'o','MarkerSize',10,'MarkerFaceColor','g','MarkerEdgeColor','k');
    legend([p1,p2,p3,p4,p5],'Mean','Standard Deviation','Heel-off','Toe-off','Toe-Strike')
    hold off
else
    legend([p1,p2],'Mean','Standard Deviation')    
end
%patch([linspace(0,100,length(dev_plot)) linspace(0,100,length(dev_plot))],[dev_plot(:,1);dev_plot(:,2)]','g');
title(strcat(tit,': Mean & Standard Deviation of Gait Cycle'))
xlabel('Gait Cycle %')
ylabel(ylab)


%Plot all cycles and mean curve
clearvars i
figure
   for i = 1:size(resamp,2)
    y(i) = plot(0:strike_factor(i):100,[data(frame(i):frame(i+1),1)],'Color',[0.6 0.6 0.6]);
   mean_curv(i,1) = mean(resamp(i,:)); 
   if i == 1
   hold on
   end
   end
   y(i+1) = plot(0:100/(length(mean_curv)-1):100,mean_curv,'Color','r','LineWidth',1.2);
   hold off
    title(strcat(tit,': Gait Cycles and Mean'))
    xlabel('Gait Cycle %')
    ylabel(ylab)
    legend(y(end),'Mean')    
clearvars i
disp(['Time Elapsed: ',num2str(toc),' seconds'])
disp(['Average Gait Cylce: ',num2str(((mean(range)+1)/2000)),' seconds'])
disp(['Longest Gait Cycle: ',num2str((max_sample/2000)),' seconds'])
disp(['Shortest Gait Cycle: ',num2str((min_sample/2000)),' seconds'])
end
