function [LF,RF] = VD(MyClient,b1)
bar_draw(0,0,b1);
while toc(tic)<=200
    [LHEE,RHEE,LF,RF] = frameupdate(MyClient);
    if -LF<=40 && -RF>=100 %&& LHEE>RHEE
            bar_draw(abs(RF),1000,b1);
    elseif -RF<=40 && -LF>=100 %&& RHEE>LHEE
            bar_draw(1000,abs(LF),b1)
    end
end