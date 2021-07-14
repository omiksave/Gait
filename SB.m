function SB(PWS)
t = tic; % Initializing Clock
PWS = PWS*1000;
prev = 10000;
while (toc(t)/60)<=28
    if floor((toc(t)/60))~= prev
        if floor(toc(t)/60)-2>0 && floor(toc(t)/60)-2<=10
            setTreadmill(PWS*(1+(5*floor((toc(t)/60)-2)/100)),PWS,250,250);
            floor(toc(t)/60)
            prev = floor((toc(t)/60));
        else
            setTreadmill(PWS,PWS,250,250);
            floor(toc(t)/60)
            prev = floor((toc(t)/60));
        end
    end 
end
setTreadmill(0,0,250,250);