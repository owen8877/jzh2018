clc; clear
'douhu';

load data/param_h.mat

engageness = 1:0.01:1.1;
figure
hold on
scores = arrayfun(@(x) scoring(x, posts_h), engageness);
validScores = arrayfun(@(x) validScoring(x, posts_h), engageness);
plot(engageness, scores)
plot(engageness, validScores)
legend({'total', 'valid'})

function s = scoring(x, posts)
    u = posts(:, 1); d = posts(:, 2); o = posts(:, 3);
    p = posts(:, 4); l = posts(:, 5);
    n = numel(l);
    P = ones(n, 1);
    P(1) = 1 - p(1) - o(1);
    for j = 2:n
        P(j) = P(j-1) * (1-p(j)-o(j));
    end
    s = sum(P./l .* x.^(0:n-1)');
end

function s = validScoring(x, posts)
    u = posts(:, 1); d = posts(:, 2); o = posts(:, 3);
    p = posts(:, 4); l = posts(:, 5);
    n = numel(l);
    P = ones(n, 1);
    P(1) = 1 - p(1) - o(1);
    for j = 2:n
        P(j) = P(j-1) * (1-p(j)-o(j));
    end
    s = sum(P./l .* (u+d) .* x.^(0:n-1)');
end