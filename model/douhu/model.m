function [post, roam, update] = model(options)
    'douhu';
    
    addpath('..');
    
    exponential = probabilityUtil('exponential');

    function posts = postPhase(postVelocity, offset, T, options)
        lambda = postVelocity * T;
        innerPostNumber = poissrnd(lambda);
        if isfield(options, 'forcePost') && options.forcePost
            innerPostNumber = max(1, innerPostNumber);
        end
        t = sort(rand(innerPostNumber, 1) * T) + offset;
        ud = options.voting(t);
        upercent = options.upVotingPercent(t);
        u = ud .* upercent;
        d = ud - u;
        op = options.ignoring(t);
        opercent = options.skipPercent(t);
        o = op .* opercent;
        p = op - o;
        l = 1 ./ options.readingTime(t);
        vu = zeros(innerPostNumber, 1); vd = zeros(innerPostNumber, 1);
        posts = [t, vu, vd, u, d, o, p, l];
    end
    
    function [time, hint, skip, voting, posts] = roamPhase(M, posts, ranking)
        t = posts(:, 1); vu = posts(:, 2); vd = posts(:, 3);
        u = posts(:, 4); d = posts(:, 5);
        o = posts(:, 6); p = posts(:, 7); l = posts(:, 8);
        n = size(posts, 1);
        
        time = zeros(n, M);
        hint = zeros(1, M);
        skip = zeros(n, M);
        voting = zeros(n, M);
        
        for i = 1:M
            readThrough = false;
            for j = 1:n
                r = ranking(j);
                skipLeaveRandom = rand(1, 1);
                if skipLeaveRandom < o(r)
                    skip(j, i) = 1;
                    continue;
                end
                
                skip(j, i) = 0;
                if skipLeaveRandom > 1-p(r)
                    break
                end
                time(j, i) = exponential(l(j));
                
                upDownRandom = rand(1, 1);
                if upDownRandom < u(r)
                    voting(j, i) = 1;
                elseif upDownRandom > 1-d(r)
                    voting(j, i) = -1;
                end
                if j == n
                    readThrough = true;
                end
            end
            if readThrough
                hint(i) = n;
            else
                hint(i) = j-1;
            end
        end
        
        umd = sum(voting, 2);
        upd = sum(abs(voting), 2);
        posts(:, 2) = vu + (umd+upd)/2;
        posts(:, 3) = vd + (upd-umd)/2;
    end

    function ranking = updatePhase(now, posts, options)
        [n, ~] = size(posts);
        score = zeros(n, 1);
        for i = 1:n
            score(i) = options.scoring(now, posts(i, :));
        end
        [~, index] = sort(score);
        ranking = zeros(n, 1);
        for i = 1:n
            ranking(index(i)) = n+1-i;
        end
    end

    post = @postPhase;
    roam = @roamPhase;
    update = @updatePhase;
end

