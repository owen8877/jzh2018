clc; clear
'douhu';

[post, roam, update] = model(struct());

totalTime = 5;
generateInterval = 1;
updateInterval = 0.5;
M = 1e3;
engageness = 0.5;
alpha = 1.5;
postVelocity = 20;
methods = {'ours', 'reddit', 'hackerNews'};
% methods = {'reddit'};

options.voting = @votingFunc;
options.upVotingPercent = @upVotingPercentFunc;
options.leaving = @leaving;
options.skipping = @skipping;
options.readingTime = @readingTimeFunc;    
options.forcePost = true;

figure
hold on
initialPosts = post(postVelocity, -generateInterval, generateInterval, options);
fprintf('%d posts are created.\n', size(initialPosts, 1))
options.forcePost = false;
for methodc = methods
    method = methodc{1};
    timestamp = 0;
    posts = initialPosts;
    ranking = (1:size(posts))';
    scores = [];
    if ~strcmp(method, 'hackerNews')
        options.scoring = @hackerNews;
    elseif ~strcmp(method, 'reddit')
        options.scoring = @reddit;
    end
    while timestamp < totalTime
        fprintf('Time: %.2f\n', timestamp)

        [time, hint, skip, voting, posts] = roam(M, posts, ranking);
        posts_h = optimize(time, hint, skip, voting);
        score = scoring(engageness, posts_h, alpha);
        timestamp = timestamp + updateInterval;
        if ~strcmp(method, 'ours')
            ranking = update(timestamp, posts, options);
        else
            ranking = findBestCore(engageness, posts_h, alpha);
        end

        topNumber = min(10, size(posts, 1));
        fprintf('Seems the top %d posts are:\n\t', topNumber)
        fprintf(' %d', ranking(1:topNumber))
        fprintf('.\n')
        fprintf('And their according voting:\n\t')
        fprintf(' %d', sum(posts(ranking(1:topNumber), 2), 2))
        fprintf('.\n')
        fprintf('Average reading time: %.2f.\n', mean(sum(time, 1)))
        fprintf('Score: %.2f.\n', score)
        scores = [scores score];
        fprintf('\n')
    end
    plot(scores)
end
legend(methods)
    
testUserNumber = 1e4;
[time, hint, skip, voting, ~] = roam(testUserNumber, posts, ranking);

save('data/user.mat', 'time', 'hint', 'skip', 'voting', 'posts', 'ranking');

%%
function s = hackerNews(now, post)
    P = post(2) - post(3);
    T = now - post(1);
    g = 1.8;
    s = (P+1) / (T+2)^g;
end

function s = reddit(now, post)
    x = post(2) - post(3);
    y = sign(x);
    z = max(1, abs(x));
    ts = -now + post(1);
    s = log10(z) + y*ts/45000;
end

function p = votingFunc(t)
    p = cos(2*pi*(t+0.5))*0.1 + 0.5;
end

function p = upVotingPercentFunc(t)
    p = cos(2*pi*(t+0.3))*0.2 + 0.5;
end

function p = skipping(t)
    p = cos(2*pi*(t+0.8))*0.05 + 0.1;
end

function p = leaving(t)
    p = cos(2*pi*(t+0.4))*0.06 + 0.1;
end

function t = readingTimeFunc(t)
    t = cos(2*pi*(t+0.1))*0.4 + 1;
end