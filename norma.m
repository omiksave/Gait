function x = norma(data)
tx = [];
for i = 1:size(data,1)
    maxa = max(data(i,:));
    mina = min(data(i,:));
    t = maxa-mina;
    tx = [tx t];
end
tx = mean(tx);
x = data/tx;
end