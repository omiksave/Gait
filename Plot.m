%% Preprocessing
b = [+1 -0.5];% Damping Range
b_up = b(1,1); b_low = b(1,2);
bc = 0; % Center of damping
sn = 0.95; % Sensitivity
e = 0.12; % Lever arm
[num,den] = butter(2,7/1000);


%%
tx_max = 1; tx_min = 1; k = 1; kp = 1;  kn = 1;
%% Kalman filter parameter intialize
T = 1/2000; %Sample Time
Tx = 0.5/1000; %Sample Time
A = [1 T 0.5*T^2;0 1 T;0 0 1];
G = [0.1667*T^3;0.5*T^2;T];
C = [1 0 0];
%% Evaluating maximum intent
tx_max = max(data.data(50*2000:100*2000,4));% Negative Damping Bi-Directional
tx_min = min(data.data(50*2000:100*2000,4));% Positive Damping Bi-Directional
%% Evaluating k
k = -log(((1-sn)*b_low)/((sn*b_low)-b_up))/tx_max ; % Unidirectional damping controller
kp = -log((1-sn)/(1+sn))/tx_max;% Negative Damping Bi-Directional
kn = -log((1+sn)/(1-sn))/tx_min;% Positive Damping Bi-Directional
%% Read files
zer = readdat('zero');
body_weight = mean(zer.data(2000:end,6));
weight = body_weight/9.81;
zero = mean(zer.data(2000:end,1)); % Goniometer base reading
ta_base = zer.data(:,2);% TA muscle base reading 5
pl_base = zer.data(:,5);% PL muscle base reading 6
gas_base = zer.data(:,3);% GAS muscle base reading 11
sol_base = zer.data(:,4);% SOL muscle base reading 12
fifteen1 = readdat('fifteen1');
fifteen1 = mean(fifteen1.data(2000:end,1));% Goniometer reading at +15 degrees
fifteen = readdat('fifteen');
fifteen = mean(fifteen.data(2000:end,1));% Goniometer reading at -15 degrees
twenty = readdat('twenty');
twenty = mean(twenty.data(2000:end,1));% Goniometer reading at -20 degrees
twenty1 = readdat('twenty1');
twenty1 = mean(twenty1.data(2000:end,1));% Goniometer reading at +20 degrees
base =((twenty+twenty1+fifteen+fifteen1)/4); % Zero reading by average (Compare with zero)
fifteen = fifteen1-base;% Substracting offset from +15
twenty = twenty1-base;% Substracting offset from +20
ank_mul = ((((fifteen*4)+(twenty*3))/(2*60))^-1)*0.01745;% Calculating multiplier (rad/V)
%% File read
clearvars Input1
data = readdat('data4');
ankle = 57.296*data.data(:,1);% Converting ankle angle to degrees from radians
%ankle = readdat('raw2'); ankle = ankle.data(:,1);
%% Estimate noise in GRF
T = 1/2000;
force = normalforce(data.data(:,8),T);
%% Get Heel Strikes
[frame,strike,ankle_norm,avg_time1] = gaitphase(force,data.data(:,1));
%% Save force and frame
save('4','force','frame')
%% Plotting robot dynamics
robodyn(data,force,frame,strike,'Walking 0 Nms/rad')
%% Plotting ankle dyanmics
for i = 1
    [m2y,d2y,t2y] = norgait(ankle_norm,frame(1:round(4/7*length(frame))-1));
    [mt,dt] = norgait(-0.25*data.data(:,6),frame);
    [mean_acc(:,i)] = norgait(data.data(:,3),frame,0,'0 Nms/rad');
    [mean_int(:,i)] = norgait(data.data(:,4),frame,0,'0 Nms/rad');
end