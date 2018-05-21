clc; clear
'douhu';

figure
s1 = subplot(1, 2, 1);
load data/param_h-reddit.mat
engageness = 0.5:0.01:1;
balance_alpha = [1, 1.25, 1.5, 1.75, 2];
hold(s1, 'on')
title('Reddit algorithm')
xlabel('x')
ylabel('score')
for alpha = balance_alpha
    scores = arrayfun(@(x) scoring(x, posts_h, alpha), engageness);
    plot(engageness, scores)
end
legend(cellfun(@(f) num2str(f), mat2cell(balance_alpha', ones(numel(balance_alpha), 1)), 'UniformOutput', false))

s2 = subplot(1, 2, 2);
load data/param_h-hackerNews.mat
engageness = 0.5:0.01:1;
balance_alpha = [1, 1.25, 1.5, 1.75, 2];
hold(s2, 'on')
title('HackerNews Algorithm')
xlabel('x')
ylabel('score')
for alpha = balance_alpha
    scores = arrayfun(@(x) scoring(x, posts_h, alpha), engageness);
    plot(engageness, scores)
end
legend(cellfun(@(f) num2str(f), mat2cell(balance_alpha', ones(numel(balance_alpha), 1)), 'UniformOutput', false))
