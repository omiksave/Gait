function prev = SB_dep(PWS,prev,t)

if floor((toc(t)/60))~= prev
    if floor(toc(t)/60)-2<=10
        setTreadmill(PWS*(1+max(0,(5*floor((toc(t)/60)-2)/100))),PWS,250,250);
        floor(toc(t)/60)
        prev = floor((toc(t)/60));
    else
        setTreadmill(PWS,PWS,250,250);
        floor(toc(t)/60)
        prev = floor((toc(t)/60));
    end
end 

