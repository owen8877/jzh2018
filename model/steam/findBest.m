clc; clear
'steam';

load data/param_h.mat

x = 1;
alpha = 1;

n = numel(lambda_h);
p_hh = [p_h; 0.5];

index = 1:n;
bestScore = Inf;
for itr = 1:100
    fprintf('Iteration %d:\n', itr)
    found = false;
    for i = 1:n
        for j = i+1:n
            permutated = index;
            permutated([i, j]) = index([j, i]);
            score = scoring(x, p_hh(permutated), lambda_h(permutated), alpha);
            
            if score < bestScore
                fprintf('(%d, %d) with score %.2f is better.\n', i, j, score)
                besti = i;
                bestj = j;
                bestScore = score;
                found = true;
            end
        end
    end
    if ~found
        break
    end
    index([besti, bestj]) = index([bestj, besti]);
end

function s = scoring(x, p, lambda, alpha)
    n = numel(lambda);
    P = ones(n, 1);
    for j = 2:n
        P(j) = P(j-1) * p(j-1);
    end
    s = sum((P./lambda .* x.^(0:n-1)').^alpha);
end