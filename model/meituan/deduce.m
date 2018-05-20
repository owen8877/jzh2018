clc; clear
'meituan';

load data/user.mat

histogram(sum(time, 1), 200);
bar(mean(skip, 2));
[lambda_h, p_h, omega_h] = optimize(time, hint, skip);

save('data/param_h.mat', 'lambda_h', 'p_h', 'omega_h');