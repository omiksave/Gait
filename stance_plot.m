function resamp = stance_plot(data,frame,strike)
range = [];
for i = 1:length(strike)
    range = [range;strike(i,3)-frame(i)];
end
max_sample = max(range)+1;
resamp = [];
for i = 1:length(strike)
    resamp = [resamp;resample(data(frame(i):strike(i,3)),max_sample,strike(i,3)-frame(i))'];
end
mean_samp = mean(resamp,1);
figure;
for i = 1:size(resamp,1)
    plot(linspace(0,100,size(resamp,2)),resamp(i,:),'Color',[0.6 0.6 0.6])
    hold on
end
p1 = plot(linspace(0,100,length(mean_samp)),mean_samp,'LineWidth',1.2,'Color','r');
legend(p1,'Mean')
xlabel('Stance Phase (%)')
