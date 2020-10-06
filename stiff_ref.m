function y1 = stiff_ref(x)
y1 = [];
for i = 1:length(x)
    if x(i)>=0 && x(i) <12
        y = (0.1*x(i)) + 0.4;
    elseif x(i)>=12 && x(i)<23
        y = (0.1455*x(i)) -0.1455;
    elseif x(i)>=23 && x(i)<33
        y = (0.17*x(i)) - 0.71;
    elseif x(i)>=33 && x(i)<41
        y = (0.1625*x(i)) - 0.4625;
    elseif x(i)>=41 && x(i)<46
        y = (-0.48*x(i)) + 25.880;
    elseif x(i)>=46 && x(i)<50
        y = 23.35 - (0.4250*x(i));
    elseif x(i)>=50 && x(i)<56
        y = 15.4333 - (0.2667*x(i));
    elseif x(i)>=56 && x(i)<68
        y = 0.9667 - (.0083*x(i));
    elseif x(i)>=68 && x(i)<100
        y = 0;
    else
        y = 0;
    end
    y1 = [y1;y];
end
end