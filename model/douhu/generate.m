clc; clear
'douhu';

[post, roam, update] = model(struct());

totalTime = 10;
deadline = 1;
updateInterval = 0.1;
timestamp = 0;
posts = [];
M = 1e3;
ranking = [];

options.voting = @votingFunc;
options.upVotingPercent = @upVotingPercentFunc;
options.ignoring = @ingoringFunc;
options.skipPercent = @skipPercentFunc;
options.readingTime = @readingTimeFunc;
options.scoring = @hackerNews;
options.forcePost = true;

while timestamp < totalTime
    fprintf('Time: %.2f\n', timestamp)
    
    if timestamp < deadline
        newPosts = post(30, timestamp, updateInterval, options);
        options.forcePost = false;
        ranking = [ranking; (size(posts, 1)+1:size(posts, 1)+size(newPosts, 1))'];
        posts = [posts; newPosts];
    
        fprintf('%d new posts are created.\n', size(newPosts, 1))
    end
    
    [time, ~, ~, ~, posts] = roam(M, posts, ranking);
    timestamp = timestamp + updateInterval;
    ranking = update(timestamp, posts, options);
    
    topNumber = min(10, size(posts, 1));
    fprintf('Seems the top %d posts are:\n\t', topNumber)
    fprintf(' %d', ranking(1:topNumber))
    fprintf('.\n')
    fprintf('And their according voting:\n\t')
    fprintf(' %d', sum(posts(ranking(1:topNumber), 2), 2))
    fprintf('.\n')
    fprintf('Average reading time: %.2f.\n', mean(sum(time, 1)))
    fprintf('\n')
end

testUserNumber = 1e4;
[time, hint, skip, voting, ~] = roam(testUserNumber, posts, ranking);

save('data/user.mat', 'time', 'hint', 'skip', 'voting', 'posts', 'ranking');

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

function p = ingoringFunc(t)
    p = cos(2*pi*(t+0.8))*0.05 + 0.1;
end

function p = skipPercentFunc(t)
    p = cos(2*pi*(t+0.4))*0.4 + 0.5;
end

function t = readingTimeFunc(t)
    t = cos(2*pi*(t+0.1))*0.4 + 1;
end