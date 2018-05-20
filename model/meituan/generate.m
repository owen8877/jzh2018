clc; clear
'meituan';

n = 10;
m = 1e5;

lambda = ones(n, 1) / 2;
p = ((n:-1:1)-1)/n;
omega = (0:n-1)/n;
meituanModel = model(n, lambda, p, omega, struct());
[time, hint, skip] = meituanModel(m);
save('data/user_decrease.mat', 'time', 'hint', 'skip', 'lambda', 'p', 'omega');

lambda = unifrnd(0.3, 1.0, n, 1);
p = unifrnd(0.7, 1.0, n, 1);
omega = unifrnd(0.0, 0.3, n, 1);
meituanModel = model(n, lambda, p, omega, struct());
[time, hint, skip] = meituanModel(m);
save('data/user_random.mat', 'time', 'hint', 'skip', 'lambda', 'p', 'omega');