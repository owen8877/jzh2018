clc; clear
'steam';

load data/user.mat

histogram(sum(time, 1), 200);
[lambda_h, p_h] = optimize(time, hint);

save('data/param_h.mat', 'lambda_h', 'p_h');