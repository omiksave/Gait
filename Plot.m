%% Preprocessing
b = [+1 -0.5];% Damping Range
b_up = b(1,1); b_low = b(1,2);
bc = 0; % Center of damping
sn = 0.95; % Sensitivity
e = 0.13; % Lever arm
[num,den] = butter(2,20/1000);
ank_mul = 0; zero = 0;zerox = 0;
avg_time = 1; imp_stage1 = 0.9;imp_stage2 = 3;imp_stage3 = 4;
T = 1/2000;
%% Setting Up Smart Shoes
s = 0.5;
x0 = 25;
datx = readdat('offset');
m45_offset = mean(datx.data(2000:end,1));
toe_offset = mean(datx.data(2000:end,2));
heel_offset = mean(datx.data(2000:end,3));
m12_offset = mean(datx.data(2000:end,4));
covmat = GMModel2.Sigma;
mu = GMModel2.mu;
weights = GMModel2.ComponentProportion;

%%
tx_max = 1; tx_min = 1; k = 1; kp = 1;  kn = 1;

%% Kalman filter parameter intialize
 %Sample Time
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
weight = mean(zer.data(2000:end,end-1))/9.81;
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
fifteen11 = fifteen1-base;% Substracting offset from +15
twenty11 = twenty1-base;% Substracting offset from +20
ank_mul1 = ((((fifteen11*4)+(twenty11*3))/(2*60))^-1)*0.01745;% Calculating multiplier (rad/V)
ank_model = fitlm([twenty1,fifteen1,zero,fifteen,twenty],[-20,-15,0,15,20]*-1*0.0174533);
ank_mul = ank_model.Coefficients.Estimate(2);
disp(['Multiplier Significance Present ', num2str(ank_model.Coefficients.pValue(2)<=0.05)])
if ank_model.Coefficients.pValue(1)<=0.05
    zerox = ank_model.Coefficients.Estimate(1);
    disp('There is a significant offset')
else
    zerox = 0;
end

%% File read
clearvars Input1
data = readdat('data3');
posi = find(data.data(:,end-2)==1);
ankle = 57.296*data.data(posi(1):posi(end),1);% Converting ankle angle to degrees from radians
%% Estimate noise in GRF
T = 1/2000;
%fof = tf([20],[1 20]);
%force1 = lsim(fof,-LeftForce(abs(length(LeftForce)-length(ankle))+1:end),linspace(0,length(LeftForce)/2000,length(LeftForce) - abs(length(LeftForce)-length(ankle))));
force = normalforce(data.data(posi(1):posi(end),end-3)-7.5,T);
%% Get Heel Strikes
[frame,strike,ankle_norm,avg_time1] = gaitphase(force,data.data(posi(1):posi(end),1),1/T);
%% Save force and frame
save('4','force','frame')
%% Plotting robot dynamics
robodyn(data,force,frame,strike,'Walking 0 Nms/rad');
%% Plotting ankle dyanmics
%frax = frame(frame>=2*60*2000);
[m3,d3,t3] = norgait(ankle_norm(1:end),frame,1);%(round(4/7*length(frame)):end));
%[mt2,dt2] = norgait(-0.05*data.data(:,6),frame);
%% Plotting nominal ankle (Stiffness only)
nom_x1 = linspace(0,100,length(m(1:t)));
nom_y1 = m(1:t);
%% Plotting reference stiffness curve, Lee/Rousse et. al
stiff_x1 = linspace(0,100,length(m(1:t)));
stiff_y1 = stiff_ref(linspace(0,54.667,length(m(1:t))));
con_stiff = mean(stiff_y1);
imp_stage1 = mean(stiff_y1(stiff_x1<=20));
imp_stage2 = mean(stiff_y1(stiff_x1>20 & stiff_x1<=60));
imp_stage3 = mean(stiff_y1(stiff_x1>60));
%% Clean temporary files
keep_clean();
%%
data0 = readdat('data0');
data1 = readdat('data1');
data2 = readdat('data2');
data3 = readdat('data3');
%data4 = readdat('data4');