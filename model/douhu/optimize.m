function posts = optimize(time, hint, skip, voting)
    'douhu';

    [n, M] = size(time);
    
    notReadCount = 0;
    readCount = zeros(n, 1);
    skipCount = zeros(n, 1);
    noskipCount = zeros(n, 1);
    for i = 1:M
        h = hint(i);
        if h > 0
            readCount(h) = readCount(h) + 1;
        else
            notReadCount = notReadCount + 1;
        end
        for j = 1:h-1
            if skip(j, i)
                skipCount(j) = skipCount(j) + 1;
            else
                noskipCount(j) = noskipCount(j) + 1;
            end
        end
    end
    
    rightCountExclude = zeros(n, 1);
    for i = n-1:-1:1
        rightCountExclude(i) = rightCountExclude(i+1) + readCount(i+1);
    end
    rightCountInclude = rightCountExclude + readCount;
    
    totalTime = sum(time, 2);
    upd = sum(voting, 2);
    umd = sum(abs(voting), 2);
    uVoting = (upd + umd) / 2;
    dVoting = (umd - upd) / 2;
    
    cvx_begin
        variables xl(n) xp(n) xo(n) xu(n) xd(n)
        maximize(rightCountInclude' * log(xl) - totalTime' * xl ...
        + skipCount' * log(xo) + noskipCount' * log(1-xo-xp) ...
        + [notReadCount; readCount(1:n-1)]' * log(xp) ...
        + uVoting' * log(xu) + dVoting' * log(xd) + (skipCount + noskipCount - umd + readCount)' * log(1-xu-xd))
        subject to
            0 <= xl;
            0 <= xp <= 1;
            0 <= xo <= 1;
            0 <= xo + xp <= 1;
            0 <= xu <= 1;
            0 <= xd <= 1;
            0 <= xu + xd <= 1;
    cvx_end

    posts = [xu xd xo xp xl];
end

