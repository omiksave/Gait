function x = resam(data,frame,strike,int,ink,ank)
x = [];
if ~exist('ank','var')
    ank = 0;
end
for i = 1:length(frame)-1
    dax = data(frame(i):frame(i+1)-1);
    if int==1
        dax = dax(1:strike(i)-frame(i)+1);
        new = [];
        for j = 1:21
            if j ==1
                n = mean(dax(1:round(0.025*length(dax))));
                g = 0.025;
                n1 = n;
            elseif j == 21
                n = mean(dax(round((0.975)*length(dax)):length(dax)));
            else
                n = mean(dax(round(g*length(dax):round((g+(0.05))*length(dax)))));
                g = g+(0.05);
            end
%             if ank==1
%                n=n-n1;
%             end
            new = [new n];
        end
    else
        dax = dax(strike(i)-frame(i)+2:frame(i+1)-frame(i));
        new = [];
        for j = 1:11
            if j ==1
                n = mean(dax(1:round(0.05*length(dax))));
                g = 0.05;
            elseif j == 11
                n = mean(dax(round((0.95)*length(dax)):length(dax)));
            else
                n = mean(dax(round(g*length(dax):round((g+(0.1))*length(dax)))));
                g = g+0.1;
            end
            new = [new n];
        end
    end
    if ink==1
        x = [x;new];
    else
        x = [x new];
    end
end