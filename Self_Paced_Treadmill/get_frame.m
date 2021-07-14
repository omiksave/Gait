function out = get_frame(MyClient,m,t,vtm)
%
% m ----> Mass of Subject in kg.
% t ----> Step time in seconds.
% v_tm -> Treadmill Speed in m/s
%
    MyClient.GetFrame();
%     a_mes = -MyClient.GetGlobalForceVector(2,1).ForceVector(2)/m;% Measured Acceleration
%     v_mes_hat = (abs(MyClient.GetGlobalCentreOfPressure(2,1).CentreOfPressure(2)-...
%                 MyClient.GetGlobalCentreOfPressure(1,1).CentreOfPressure(2))/t)-(readTreadmill());
%     p_mes_hat = 0.5*(MyClient.GetGlobalCentreOfPressure(2,1).CentreOfPressure(2)+...% Estimated Velocity
%                 MyClient.GetGlobalCentreOfPressure(1,1).CentreOfPressure(2));% Estimated Position
    out = [-MyClient.GetGlobalForceVector(2,1).ForceVector(2)/m;
            (abs(MyClient.GetGlobalCentreOfPressure(2,1).CentreOfPressure(2)-...
                MyClient.GetGlobalCentreOfPressure(1,1).CentreOfPressure(2))/t)-(vtm);
                0.5*(MyClient.GetGlobalCentreOfPressure(2,1).CentreOfPressure(2)+...% Estimated Velocity
                MyClient.GetGlobalCentreOfPressure(1,1).CentreOfPressure(2));abs(MyClient.GetGlobalForceVector(2,1).ForceVector(3))];
end