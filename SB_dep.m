function prev = SB_dep(PWS,prev,t)

if floor((toc(t)/60))~= prev
    if (toc(t)/60)-2>0 && (toc(t)/60)-2<=11
        setTreadmill(PWS*(1+(5*floor((toc(t)/60)-2)/100)),PWS,250,250);
        ceil(toc(t)/60)
        prev = floor((toc(t)/60));
    else
        setTreadmill(PWS,PWS,250,250);
        ceil(toc(t)/60)
        prev = floor((toc(t)/60));
    end
end 

