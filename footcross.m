function [LF,RF] = VDSB(MyClient,b1)
bar_draw(0,0,b1);
while toc(t)<=200
    [LHEE,RHEE,LF,RF] = frameupdate(MyClient);
    if -LF<=40 && -RF>=100 && LHEE>RHEE
            bar_draw(LHEE-RHEE,100,b1);
    elseif -RF<=40 && -LF>=100 && RHEE>LHEE
            bar_draw(100,RHEE-LHEE,b1)
    end
end