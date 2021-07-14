function set_speed(trg,v,kalman)
flushoutput(trg);
vtm = min(max(0.8,(v/1000) + 0.25*kalman.UserData.pv_kf(2)+0.1*kalman.UserData.pv_kf(1)),1.2);
atm = min(max((vtm-(v/1000))/0.5,0.25),0.9);
norm = reshape(int16toBytes([vtm*1000,vtm*1000,0,0,atm*1000,atm*1000,0,0,0])',18,1);
antinorm = bitcmp(norm);
fwrite(trg,[0,norm',antinorm',zeros(1,27)],'uint8');
pause(0.1);
%disp([vtm,atm])
end