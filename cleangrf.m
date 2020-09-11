function grf = cleangrf(force,threshold)
force(force<=threshold)=0;
grf = force;
end