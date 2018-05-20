clc; clear
'steam';

n = 10;
lambda = ones(n, 1) / 2;
p = ((n:-1:1)-1)/n;
steamModel = model(n, lambda, p, struct());

m = 5e3;
[time, hint] = steamModel(m);
save('data/user.mat', 'time', 'hint');