function robodyn(data,force,frame,strike,figtitle)
tic;
tout = data.data(:,end);
figure;

sgtitle(figtitle)

plot1 = subplot(4,1,1);
plot(tout,force)
hold on
for i = 1:length(frame)
    p = plot([tout(frame(i)) tout(frame(i))],[-10 1000],'--','Color',[0.83,0.19,0.55]);
end
ylim([-5 950])
title('Ground Reaction Force')
xlabel('Time(s)')
ylabel('Force(N)')
legend([p],'Heel-Strike')

plot2 = subplot(4,1,2);

%plot(tout,uf.signals.values(:,1))
for i = 1:length(frame)
    plot([tout(frame(i)) tout(frame(i))],[-100 100],'--','Color',[0.83,0.19,0.55]);
    mex(i) = data.data(frame(i),1);
    hold on
end
datx = data.data(:,1);
datx = datx - mean(mex);

plot(tout,datx,'Color','b')
%count= 1;
for i=1:length(strike)
    p1 = plot([tout(frame(i)) tout(frame(i+1))],[datx(frame(i),1) datx(frame(i+1),1)],'o','MarkerSize',10,'MarkerFaceColor','b','MarkerEdgeColor','k');
    %df = frame(i+1)-frame(i);
    %heel_off = find(datx == max(datx(frame(i):frame(i)+round(0.55*df))));
    %toe_off = find(datx == min(datx(heel_off:frame(i+1))));
    p2 = plot(tout(strike(i,2)),datx(strike(i,2),1),'o','MarkerSize',10,'MarkerFaceColor','r','MarkerEdgeColor','k');
    p3 = plot(tout(strike(i,3)),datx(strike(i,3),1),'o','MarkerSize',10,'MarkerFaceColor','g','MarkerEdgeColor','k');
    p4 = plot(tout(strike(i,1)),datx(strike(i,1),1),'o','MarkerSize',10,'MarkerFaceColor','m','MarkerEdgeColor','k');    
    %count = count+1;
end
legend([p1,p2,p3,p4],'Heel-Strike','Heel-Off','Toe-off','Toe-Strike')
ylim([min(datx(4000:end,1)) max(datx(4000:end,1))])
title('Position')
xlabel('Time(s)')
ylabel('Position(rad)')

plot3 = subplot(4,1,3);
y2 = data.data(:,2);
plot(tout,y2)
hold on
for i = 1:length(frame)
    plot([tout(frame(i)) tout(frame(i))],[-100 100],'--','Color',[0.83,0.19,0.55]);
end
ylim([min(data.data(4000:end,2)) max(data.data(4000:end,2))])
title('Velocity')
xlabel('Time(s)')
ylabel('Velocity (rad/s)')

plot4 = subplot(4,1,4);
y3 = data.data(:,3);
plot(tout,y3)
hold on
for i = 1:length(frame)
    plot([tout(frame(i)) tout(frame(i))],[-100 100],'--','Color',[0.83,0.19,0.55]);
end
ylim([min(data.data(4000:end,3)) max(data.data(4000:end,3))])
title('Accelaration')
xlabel('Time(s)')
ylabel('Accelaration(rad/s^2)')
linkaxes([plot1,plot2,plot3,plot4],'x')

figure;

sgtitle(figtitle)

plot9 = subplot(5,1,1);
plot(tout,force)
hold on
for i = 1:length(frame)
    plot([tout(frame(i)) tout(frame(i))],[-10 1000],'--','Color',[0.83,0.19,0.55]);
end
ylim([-5 950])
title('Ground Reaction Force')
xlabel('Time(s)')
ylabel('Force(N)')

plot5 = subplot(5,1,2);
y4 = data.data(:,4);
plot(tout,y4)
hold on
for i = 1:length(frame)
    plot([tout(frame(i)) tout(frame(i))],[-1000 1000],'--','Color',[0.83,0.19,0.55]);
end
ylim([min(data.data(4000:end,4)) max(data.data(4000:end,4))])
title('Intent Factor')
xlabel('Time')
ylabel('Intent Factor')

plot6 = subplot(5,1,3);
y5 = data.data(:,5);
plot(tout,y5)
hold on
for i = 1:length(frame)
    plot([tout(frame(i)) tout(frame(i))],[-100 100],'--','Color',[0.83,0.19,0.55]);
end
ylim([-2 2])
title('Damping')
xlabel('Time')
ylabel('Damping (N*s*m/rad)')

plot7 = subplot(5,1,4);
y6 = data.data(:,6);
%m = 
plot(tout,y6,'Color','b');
hold on
for i = 1:length(frame)
    plot([tout(frame(i)) tout(frame(i))],[-100 100],'--','Color',[0.83,0.19,0.55]);
end
%g = plot(tout,f_at,'Color','r');
ylim([-5 5])
title('Torque')
xlabel('Time')
ylabel('Torque(Nm)')
%legend([m,g],'Commanded Torque','Feedback Torque')

plot8 = subplot(5,1,5);
y7 = data.data(:,7);
% y8 = data.signals.values(:,8);
plot(tout,y7)
hold on
for i = 1:length(frame)
    plot([tout(frame(i)) tout(frame(i))],[-100 100],'--','Color',[0.83,0.19,0.55]);
end
ylim([-60 60])
% legend('Calculated','Measured')
title('Force')
xlabel('Time')
ylabel('Force(N)')

linkaxes([plot9,plot5,plot6,plot7,plot8],'x')
disp(['Time Elapsed: ',num2str(toc),' seconds'])
end