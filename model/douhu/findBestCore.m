function index = findBestCore(x, posts_h, alpha)
    'douhu';

    n = size(posts_h, 1);

    index = 1:n;
    bestScore = 0;
    for itr = 1:100
        fprintf('Iteration %d:\n', itr)
        found = false;
        for i = 1:n
            for j = i+1:n
                permutated = index;
                permutated([i, j]) = index([j, i]);
                score = scoring(x, posts_h(permutated, :), alpha);

                if score > bestScore
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
end