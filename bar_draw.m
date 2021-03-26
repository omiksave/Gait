function bar_draw(LSL,RSL,b1,b2,lim)
if isempty(RSL)
    set(b2,'Xdata',linspace(lim,lim-LSL,60));
else 
    set(b1,'Xdata',linspace(lim,lim-RSL,60));
end
drawnow;
end