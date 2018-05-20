clc; clear
'douhu';

load data/param_h.mat

engageness = 1:0.01:1.1;
figure
hold on
scores = arrayfun(@(x) scoring(x, posts_h, false), engageness);
validScores = arrayfun(@(x) scoring(x, posts_h, true), engageness);
plot(engageness, scores)
plot(engageness, validScores)
legend({'total', 'valid'})