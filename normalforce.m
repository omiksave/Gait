function grf = normalforce(force,T)
figure;
plot(force)
ylabel('Force (N)')
xlabel('Samples')
title('Step(1/4): Raw Aquired Signal')
n = input('Input filter order: \n');
fc = input('Input filter cut-off frequency: \n');
close all;
itr = true;
i = 1;
while itr
    [b,a] = butter(n,fc*2*T); %(Order, Cut-off/Fs/2)
    force_fil(:,i) = filtfilt(b,a,force);
    figure;
    plt1 = plot(force);
    hold on
    for j = 1:i
        if j==i
            hold on
            plt(j) = plot(force_fil(:,j),'Linewidth',1.2,'Color',[0.96 0.3 0.33]);
        else
            hold on
            plt(j) = plot(force_fil(:,j),'Color',[0.9 0.9 0.9]);
        end
    end
    ylabel('Force (N)')
    xlabel('Samples')
    title('Step(2/4): Check Filtered Signal')
    if i==1
        legend([plt1,plt(i)],'Raw force data','Current filter')
    else
        legend([plt1,plt(i-1),plt(i)],'Raw force data','Discarded filters','Current filter')
    end
    fdbk = input('Do you accept the filtering? (y/n)\n','s');
    if fdbk == 'y'
        itr = false;
        force_fil = force_fil(:,i);
        close all
    else
        n = input('Input new filter order: \n');
        fc = input('Input new filter cut-off frequency: \n');
        close all;
        i = i+1;
    end
end
figure;
plot(force_fil)
xlim([1 length(force_fil)])
xlabel('Samples')
ylabel('Force (N)')
title('Step(3/4): Set Noise Window')
w = input('Set Window: \n');
sweep = force_fil; restore = force_fil;
sweep(sweep>w)=w;
[p,l] = findpeaks(sweep);p(p>=w)=0; threshold = max(p);
itr = true;
while itr
    disp(['Normalizing at threshold ',num2str(threshold),' N \n'])
    figure;
    force_fil(force_fil<=threshold)=0;
    p1 = plot(force_fil,'Linewidth',1.2,'Color',[0.96 0.3 0.44]);
    hold on
    plt1 = plot(restore,'Color',[0.4 0 1]);
    plot(l(p == max(p)),restore(l(p == max(p))),'o','MarkerSize',10,'MarkerFaceColor','g','MarkerEdgeColor','k');
    xlim([1 length(force_fil)])
    xlabel('Samples')
    ylabel('Force (N)')
    title('Step(4/4): Check Normalized Force')
    legend([plt1 p1],'Raw Force','Normalized Force')
    fdbk = input('Do you accept the filtering? (y/n): \n','s');
    if fdbk == 'y'
        itr = false;
    else
        close all;
        force_fil = restore;
        figure; plot(force_fil);
        title('Step(4/4): Set Noise Window')
        threshold = input('Enter threshold manually: \n');
        force_fil(force_fil<threshold)=0;
        close all;
    end
end
disp('Press any key to continue');
grf = force_fil;
w = waitforbuttonpress;
if w==1
    close all;
end
end