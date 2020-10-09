clearvars Input1
mvc = readdat('mvc');
[b1,a1] = butter(2,4/1000);
ta_max = max(filtfilt(b1,a1,abs(mvc.data(:,1)-mean(ta_base))));
gas_max = max(filtfilt(b1,a1,abs(mvc.data(:,2)-mean(gas_base))));
sol_max = max(filtfilt(b1,a1,abs(mvc.data(:,3)-mean(sol_base))));
pl_max = max(filtfilt(b1,a1,abs(mvc.data(:,4)-mean(pl_base))));
%%
clearvars emg
emg = readdat('emg1');
[b1,a1] = butter(2,4/1000);
ta = filtfilt(b1,a1,abs(emg.data(:,1)-mean(ta_base)));
gas = filtfilt(b1,a1,abs(emg.data(:,2)-mean(gas_base)));
sol = filtfilt(b1,a1,abs(emg.data(:,3)-mean(sol_base)));
pl = filtfilt(b1,a1,abs(emg.data(:,4)-mean(pl_base)));
ta(1:96) = []; sol(1:96) = [];gas(1:96) = []; pl(1:96) = [];
%%
framex = frame(1:end-1);
%%
[met1,det1] = norgait((ta/ta_max)*100,framex);
[mes1,des1] = norgait((sol/sol_max)*100,framex);
[meg1,deg1] = norgait((gas/gas_max)*100,framex);