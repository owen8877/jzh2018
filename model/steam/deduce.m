clc; clear
'steam';

figure
subplot(1, 2, 1);
load data/user_random.mat
histogram(sum(time, 1), 100);
[lambda_h, p_h] = optimize(time, hint);
disp([lambda_h lambda]')
fprintf('|l_h-l|/|l|: %.4e\n', norm(lambda_h - lambda) / norm(lambda))
disp([p_h p(1:end-1)]')
fprintf('|p_h-p|/|p|: %.4e\n', norm(p_h - p(1:end-1)) / norm(p(1:end-1)))

subplot(1, 2, 2);
load data/user_decrease.mat
histogram(sum(time, 1), 100);
[lambda_h, p_h] = optimize(time, hint);
disp([lambda_h lambda]')
fprintf('|l_h-l|/|l|: %.4e\n', norm(lambda_h - lambda) / norm(lambda))
disp([p_h p(1:end-1)']')
fprintf('|p_h-p|/|p|: %.4e\n', norm(p_h - p(1:end-1)') / norm(p(1:end-1)))

% [lambda_h, p_h] = optimize(time, hint);

% save('data/param_h_decrease.mat', 'lambda_h', 'p_h');