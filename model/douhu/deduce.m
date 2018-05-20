clc; clear
'douhu';

load data/user.mat

figure
histogram(sum(time, 1), 200);
figure
bar(mean(skip, 2));

posts_h = optimize(time, hint, skip, voting);

save('data/param_h.mat', 'posts_h');