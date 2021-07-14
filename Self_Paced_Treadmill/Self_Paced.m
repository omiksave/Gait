Client.LoadViconDataStreamSDK();
MyClient = Client();
MyClient.Connect( 'localhost:801' );
%%
MyClient.EnableDeviceData();
MyClient.EnableMarkerData();
%%
kalman = kalmanrt(1/50);
%%
contact = false;
%%
t = tic;
setTreadmill(1000,0,250,2500);
pause(4)
vtm = readTreadmill()/1000;
tx1 = 10;
while toc(t)<180
    tx = tic;
    out = get_frame(MyClient,m,1/50,vtm);
    kalman.loopesh(out(1),out(2),out(3),contact,vtm);
    if contact==false && out(end)>=(0.2*m*9.8) && tx1>=4
        contact = true;
        vtm = readTreadmill()/1000;
        setTreadmill(kalman.solx(1)*1000,0,kalman.solx(2)*1000,250);
        tx1 = tic;
        disp('pass')
    elseif contact ==true && out(end)>=(0.2*m*9.8)
        continue;
    elseif contact ==true && out(end)<=(0.2*m*9.8)
        contact = false;
    end 
   pause(1-toc(tx))
end
        
        
        