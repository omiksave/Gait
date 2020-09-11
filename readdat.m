function dat = readdat(x)
%READDAT accepts Simulink Real-Time data file in .dat format and outputs a easy to handle structure format.
%
%Procedure to extract signals:
%
%variable = READDAT('filename'); This step reads .dat file and stores as structure
%
%variable_n = variable.data; This step extracts the signals from the structure and stores in array 
   walk = fopen(strcat(x,'.DAT'));
   live_data=fread(walk);
   dat = SimulinkRealTime.utils.getFileScopeData(live_data);
end