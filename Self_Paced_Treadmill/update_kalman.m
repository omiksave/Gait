function update_kalman(obj,~,timer_vicon,trg)
v = trg.UserData.vtm(1);
mes = timer_vicon.UserData.movg;
a_mes = (mes(2)/timer_vicon.UserData.m);
v_mes = ((mes(3)-mes(4))/obj.UserData.clock)-(v/1000);
%disp(v)
p_mes = 0.5*(mes(3)+mes(4));
%%
obj.UserData.pv_kf = (obj.UserData.A*obj.UserData.pv_kf)+(obj.UserData.B*a_mes);
obj.UserData.P = obj.UserData.A*obj.UserData.P*obj.UserData.A' + obj.UserData.B.*obj.UserData.Q.*obj.UserData.B';

if mes(1)>=50 && obj.UserData.contact == 0%HeelStrike
    obj.UserData.contact = 1;
    obj.UserData.clock = obj.UserData.sclock;
    obj.UserData.sclock = obj.Period;
    obj.UserData.K = obj.UserData.P/(obj.UserData.P+obj.UserData.R);
    obj.UserData.pv_kf = obj.UserData.pv_kf + obj.UserData.K*([p_mes;v_mes]-obj.UserData.yk);
    obj.UserData.P = (eye(2)-obj.UserData.K)*obj.UserData.P;
    obj.UserData.yk = obj.UserData.pv_kf;
    set_speed(trg,v,obj);
elseif mes(1)<=50 %&& obj.UserData.contact == 1
    obj.UserData.sclock = obj.UserData.sclock+obj.Period;
    obj.UserData.contact = 0;
end
end