clc; clear
'douhu';

% load data/user-reddit.mat
% 
% figure
% histogram(sum(time, 1), 200);
% figure
% bar(mean(skip, 2));
% 
% posts_h = optimize(time, hint, skip, voting);
% 
% save('data/param_h-reddit.mat', 'posts_h');
% 
% load data/user-reddit.mat
% 
% figure
% histogram(sum(time, 1), 200);
% figure
% bar(mean(skip, 2));
% 
% posts_h = optimize(time, hint, skip, voting);
% 
% save('data/param_h-reddit.mat', 'posts_h');

f1 = figure();
f2 = figure();

load data/user-reddit.mat
figure(f1);
subplot(1, 2, 1);
histogram(sum(time, 1), 100);
title('Reddit algorithm')
figure(f2);
subplot(1, 2, 1);
bar(mean(skip, 2));
title('Reddit algorithm')
posts_h = optimize(time, hint, skip, voting);
save('data/param_h-reddit.mat', 'posts_h');

load data/user-hackerNews.mat
figure(f1);
subplot(1, 2, 2);
histogram(sum(time, 1), 100);
title('HackerNews Algorithm')
figure(f2);
subplot(1, 2, 2);
bar(mean(skip, 2));
title('HackerNews Algorithm')
posts_h = optimize(time, hint, skip, voting);
save('data/param_h-hackerNews.mat', 'posts_h');