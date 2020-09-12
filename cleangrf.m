function grf = cleangrf(force,threshold)
%
% Add deadzone from -ve infinity to threshold
%  
  force(force<=threshold)=0;
  grf = force;
end
