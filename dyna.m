function dyna(ankle,frame,ylab,title_x,int)
%DYNA is a function that plots data, normalized in gait cycles along with its mean
%
%Usage:
%DYNA(signal,frame,ylab,title,int)
%
%signal - input signal that needs to be normalized and plotted
%
%frame - a vector containing sample number. Consecutive sample numbers
%define one cycle. For e.g. signal(frame(1):frame(2)) is one (gait) cycle.
%See also GAITPHASE. 
%
%ylab - Label of y axis of the plot. X axis is 'Gait Cycle (%)'. If unsure skip.
%
%title - Title of the plot. Legends only indicate the mean curve. If unsure skip.
%
%int - 1 enables toe-strike, heel-off and toe-off indication. Use 1 only for ankle data. For all other signals,
%skip  
tic;
if ~exist('ylab','var')
    ylab = [];
end
if ~exist('title_x','var')
    title_x = [];
end
if ~exist('int','var')
    int = 0;
end
range = abs(diff(frame));%Count sample range for heelstrike
max_sample = max(range)+1; %Cycle with most number of points
clearvars i
% Normalize gait cycle to percentage (0 - 100)
for i=1:length(range)
    strike_factor(i,1) = 100/(range(i));
    sample(i,1) = range(i)+1;
end
clearvars i
%Resample all deficient gait cycles
% resamp = zeros();
for i = 1:length(range)
    if sample(i) ~= max_sample
        resamp(:,i) = resample(ankle(frame(i):frame(i+1)),max_sample,sample(i));
    else
        resamp(:,i) = ankle(frame(i):frame(i+1));
    end
end
%Find mean of all gait cycles
for i = 1:length(resamp)
    mean_curv(i,1) = mean(resamp(i,:));   % Mean of all points on Gait Cycle
end
clearvars i
   for i = 1:length(range)
   y(i) = plot(0:strike_factor(i):100,[ankle(frame(i):frame(i+1),1)],'Color',[0.6 0.6 0.6]);
   mean_curv(i,1) = mean(resamp(i,:)); 
   if i == 1
   hold on
   end
   end
   p1 = plot(0:100/(length(mean_curv)-1):100,mean_curv,'Color','r','LineWidth',1.2);
   if int==1  
    toe_strike = find(mean_curv == min(mean_curv(1:0.25*max_sample)));
    heel_off = find(mean_curv == max(mean_curv));
    toe_off = find(mean_curv == min(mean_curv(heel_off:end)));
    p5 = plot((toe_strike/length(mean_curv))*100,mean_curv(toe_strike),'o','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','k');
    p3 = plot((heel_off/length(mean_curv))*100,mean_curv(heel_off),'o','MarkerSize',10,'MarkerFaceColor','g','MarkerEdgeColor','k');
    p4 = plot((toe_off/length(mean_curv))*100,mean_curv(toe_off),'o','MarkerSize',10,'MarkerFaceColor','b','MarkerEdgeColor','k');
    legend([p1,p5,p3,p4],'Mean','Toe-Strike','Heel-off','Toe-off')
    hold off
   else
        legend([p1],'Mean')    
   end
    title(title_x)
    ylim([min(resamp(:)) max(resamp(:))]);
    %ylim([0 100]);
    xlabel('Gait Cycle %')
    ylabel(ylab)
    
disp(['Elapsed time: ',num2str(toc),' seconds'])
end