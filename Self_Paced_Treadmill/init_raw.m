function init_raw(obj,event,m)
w= 50;
obj.UserData.fzr = zeros(w,1);
obj.UserData.fyr = zeros(w,1);
obj.UserData.copyr = zeros(w,1);
obj.UserData.copyl = zeros(w,1);
obj.UserData.movg = zeros(4,1);
obj.UserData.m = m;
%obj.UserData.h = plot(linspace(0,1,w),obj.UserData.fzr);
end