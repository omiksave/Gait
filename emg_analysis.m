clearvars Input1
mvc = readdat('mvc');
[b1,a1] = butter(2,5/1000);
ta_max = max(filtfilt(b1,a1,abs(mvc.data(:,1)-mean(ta_base))));
gas_max = max(filtfilt(b1,a1,abs(mvc.data(:,2)-mean(gas_base))));
sol_max = max(filtfilt(b1,a1,abs(mvc.data(:,3)-mean(sol_base))));
pl_max = max(filtfilt(b1,a1,abs(mvc.data(:,4)-mean(pl_base))));
%%
clearvars emg
emg = readdat('emg1');
[b1,a1] = butter(2,5/1000);
ta = filtfilt(b1,a1,abs(emg.data(:,1)-mean(ta_base)));
gas = filtfilt(b1,a1,abs(emg.data(:,2)-mean(gas_base)));
sol = filtfilt(b1,a1,abs(emg.data(:,3)-mean(sol_base)));
pl = filtfilt(b1,a1,abs(emg.data(:,4)-mean(pl_base)));
ta(1:96) = []; sol(1:96) = [];gas(1:96) = []; pl(1:96) = [];
%%
framex = frame(1:end-1);
%%
mean_ta4 = norgait(ta,framex);
mean_sol4 = norgait(sol,framex);
mean_gas4 = norgait(gas,framex);

%%
figure;
suptitle('Muscle Activity (No Robot)')
pl1 = subplot(3,1,1);
dyna((ta/ta_max)*100,framex,[],'TA');
ylabel('Muscle Activation (%)')
pl2 = subplot(3,1,2);
dyna((gas/gas_max)*100,framex,[],'GAS');
ylabel('Muscle Activation (%)')
pl3 = subplot(3,1,3);
dyna((sol/sol_max)*100,framex,[],'SOL');
ylabel('Muscle Activation (%)')
% pl4 = subplot(4,1,4)
% dyna((pl/pl_max)*100,frame,[],'PL');
% ylabel('Muscle Activation (%)')
linkaxes([pl1,pl2,pl3],'x');
%%
plot(0:100/(length(mean_sol1)-1):100,(mean_ta1/ta_max)*100)
hold on
plot(0:100/(length(mean_sol2)-1):100,(mean_ta2/ta_max)*100)
plot(0:100/(length(mean_sol3)-1):100,(mean_ta3/ta_max)*100)
plot(0:100/(length(mean_sol4)-1):100,(mean_ta4/ta_max)*100)
legend('0 Nms/rad','+0.5 Nms/rad','[+1 -0.5] Nms/rad','No Robot')
title('SOL Mean Muscle Activation')