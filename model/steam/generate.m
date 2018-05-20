clc; clear
'steam';

n = 10;
lambda = ones(n, 1) / 2;
p = ((n:-1:1)-1)/n;
% lambda = unifrnd(0.3, 1.0, n, 1);
% p = unifrnd(0.7, 1.0, n, 1);
steamModel = model(n, lambda, p, struct());

m = 1e4;
[time, hint] = steamModel(m);
save('data/user_decrease.mat', 'time', 'hint', 'lambda', 'p');