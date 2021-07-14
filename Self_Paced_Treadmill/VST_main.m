Client.LoadViconDataStreamSDK();
%%
MyClient = Client();
MyClient.Connect( 'localhost:801' );
%%
MyClient.EnableDeviceData();
MyClient.EnableMarkerData();
%%
mass = 80;
%%

timer_vicon = timer('Name','vicon','ExecutionMode','fixedSpacing','Period',1/100,'StartFcn',{@init_raw,mass},'StopFcn',{@clear_raw},'TimerFcn',{@update_raw,MyClient});
%timer_test = timer('ExecutionMode','fixedRate','Period',10,'StartFcn',{@test_start},'StopFcn',{@test_stop},'TimerFcn',{@test_run});
trg = tcpip('localhost',4000,'BytesAvailableFcnMode','byte','BytesAvailableFcnCount',32,'BytesAvailableFcn',{@update_vtm},'InputBufferSize',32,'OutputBufferSize',64);%,'TimerPeriod',5,'TimerFcn',{@set_speed,timer_test});
timer_kalman = timer('Name','kalman','StartDelay',1,'ExecutionMode','fixedSpacing','Period',1/100,'StartFcn',{@init_kalman},'StopFcn',{@clear_kalman},'TimerFcn',{@update_kalman,timer_vicon,trg});
%%
start([timer_vicon,timer_kalman])
disp('success')
fopen(trg);