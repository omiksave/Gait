function h = area_plot(dev,men,color)
if size(dev,1)> size(dev,2)
    dev = dev';
end
if size(men,1)>size(men,2)
    men = men';
end
x = [linspace(0,100,length(men)),fliplr(linspace(0,100,length(men)))];
y = [dev(1,:),fliplr(dev(2,:))];

h = plot(linspace(0,100,length(men')),men',color,'LineWidth',1.5);
hold on
h = fill(x,y,color);
set(h,'facealpha',0.1)
end