function s = scoring(x, posts, alpha)
    u = posts(:, 1); d = posts(:, 2); s = posts(:, 3);
    t = posts(:, 4); l = posts(:, 5);
    noeff = 1 - u - d;
    n = numel(l);
    
    phi = s + noeff - s.*noeff;
    P = ones(n, 1);
    for j = 2:n
        P(j) = P(j-1) * (1-t(j-1));
    end
    s = sum((1-phi) .* (1-(1-alpha)*phi) .* (P./l .* x.^(0:n-1)').^alpha);
end