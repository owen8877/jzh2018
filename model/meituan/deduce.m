clc; clear
'meituan';

f1 = figure();
f2 = figure();

load data/user_random.mat
figure(f1);
subplot(1, 2, 1);
histogram(sum(time, 1), 100);
figure(f2);
subplot(1, 2, 1);
bar(mean(skip, 2));
[lambda_h, p_h, omega_h] = optimize(time, hint, skip);
fprintf('%.3f & ', [lambda_h lambda])
fprintf('|l_h-l|/|l|: %.4e\n', norm(lambda_h - lambda) / norm(lambda))
fprintf('%.3f & ', [p_h p(1:end-1)])
fprintf('|p_h-p|/|p|: %.4e\n', norm(p_h - p(1:end-1)) / norm(p(1:end-1)))
fprintf('%.3f & ', [omega_h omega])
fprintf('|o_h-o|/|o|: %.4e\n', norm(omega_h - omega) / norm(omega))
save('data/param_h_random.mat', 'lambda_h', 'p_h', 'omega_h');

load data/user_decrease.mat
figure(f1);
subplot(1, 2, 2);
histogram(sum(time, 1), 100);
figure(f2);
subplot(1, 2, 2);
bar(mean(skip, 2));
[lambda_h, p_h, omega_h] = optimize(time, hint, skip);
fprintf('%.3f & ', [lambda_h lambda])
fprintf('|l_h-l|/|l|: %.4e\n', norm(lambda_h - lambda) / norm(lambda))
fprintf('%.3f & ', [p_h p(1:end-1)'])
fprintf('|p_h-p|/|p|: %.4e\n', norm(p_h - p(1:end-1)') / norm(p(1:end-1)))
fprintf('%.3f & ', [omega_h omega'])
fprintf('|o_h-o|/|o|: %.4e\n', norm(omega_h - omega') / norm(omega'))
save('data/param_h_decrease.mat', 'lambda_h', 'p_h', 'omega_h');