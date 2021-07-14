function init_kalman(obj,event)

obj.UserData.pv_kf = [0;0];
obj.UserData.P0 = (1/1000)*[3.5 1.5;1.5 1.6];
obj.UserData.P = obj.UserData.P0;
obj.UserData.R = (1/1000)*[0.6 0;0 7.2];
obj.UserData.A = [1 obj.Period;0 1];
obj.UserData.B = [0.5*obj.Period^2;obj.Period];
obj.UserData.Q = 2.9*obj.UserData.B*obj.UserData.B';
obj.UserData.K = zeros(2,2);
obj.UserData.yk = zeros(2,1);
obj.UserData.sclock = obj.Period;
obj.UserData.clock = 0.4;
obj.UserData.contact = 0;
end