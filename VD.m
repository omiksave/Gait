function VD(MyClient,b1,b2,lim)
t = tic;
while (toc(t)/60)<=28
    [LHEE,RHEE,LF,RF] = frameupdate(MyClient);
    if LF<=40 && RHEE>LHEE && floor(toc(t)/60)-2<=10
            bar_draw(max(0,RHEE-LHEE),[],b1,b2,lim);
    elseif RF<=40 && LHEE>RHEE && floor(toc(t)/60)-2<=10
            bar_draw([],(1-max(0,(3*floor((toc(t)/60)-2)/100)))*max(0,LHEE-RHEE),b1,b2,lim);
    end
    floor(toc(t)/60)
end