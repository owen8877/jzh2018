function [lambda, p, omega] = optimize(time, hint, skip)
    'meituan';

    [n, M] = size(time);
    
    readCount = zeros(n, 1);
    skipCount = zeros(n, 1);
    noskipCount = zeros(n, 1);
    for i = 1:M
        h = hint(i);
        readCount(h) = readCount(h) + 1;
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
    
    cvx_begin
        variables xl(n) xp(n-1) xo(n)
        maximize(rightCountInclude' * log(xl) - totalTime' * xl ...
        + (rightCountExclude(1:n-1)-skipCount(1:n-1))' * log(xp) + readCount(1:n-1)' * log(1-xp) ...
        + skipCount' * log(xo) + noskipCount' * log(1-xo))
        subject to
            0 <= xl;
            0 <= xp <= 1;
            0 <= xo <= 1;
    cvx_end

    lambda = xl;
    p = xp;
    omega = xo;
end

