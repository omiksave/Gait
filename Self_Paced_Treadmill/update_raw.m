function update_raw(obj,event,MyClient)
MyClient.GetFrame();
obj.UserData.fzr= [obj.UserData.fzr(2:end);-MyClient.GetGlobalForceVector(2,1).ForceVector(3)];
obj.UserData.fyr= [obj.UserData.fyr(2:end);-MyClient.GetGlobalForceVector(2,1).ForceVector(2)];
obj.UserData.copyr= [obj.UserData.copyr(2:end);MyClient.GetGlobalCentreOfPressure(2,1).CentreOfPressure(2)];
obj.UserData.copyl= [obj.UserData.copyl(2:end);MyClient.GetGlobalCentreOfPressure(1,1).CentreOfPressure(2)];
obj.UserData.movg = [max(0,mean(obj.UserData.fzr));
                    mean(obj.UserData.fyr);
                    mean(obj.UserData.copyr);
                    mean(obj.UserData.copyl)];
% set(obj.UserData.h,'YData',obj.UserData.fzr);
% drawnow;
end