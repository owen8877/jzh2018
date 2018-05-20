clc; clear
'meituan';

n = 10;
lambda = ones(n, 1) / 2;
p = ((n:-1:1)-1)/n;
omega = (0:n-1)/n;
meituanModel = model(n, lambda, p, omega, struct());

m = 1e5;
[time, hint, skip] = meituanModel(m);
save('data/user.mat', 'time', 'hint', 'skip');