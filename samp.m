function new = samp(old,freq)
count = 1;
new = [];
for i = 1:length(old)/freq
    new = [new;mean(old(count:count+freq-1))];
    count = count+freq;
end