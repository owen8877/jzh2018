function [lambda, p] = optimize(time, hint)
    'steam';

    [n, M] = size(time);
    
    readCount = zeros(n, 1);
    for i = 1:M
        readCount(hint(i)) = readCount(hint(i)) + 1;
    end
    
    rightCountExclude = zeros(n, 1);
    for i = n-1:-1:1
        rightCountExclude(i) = rightCountExclude(i+1) + readCount(i+1);
    end
    rightCountInclude = rightCountExclude + readCount;
    
%     function f = loss(x)
%         xl = x(1:n);
%         xp = x(n+1:2*n-1);
%         totalTime = sum(time, 2);
%         f = rightCountInclude' * log(xl) - totalTime' * xl ...
%             + rightCountExclude(1:n-1)' * log(xp) + readCount(1:n-1)' * log(1-xp);
%         f = -f ./ M;
%     end
%     
%     function g = gradient(x)
%         xl = x(1:n);
%         xp = x(n+1:2*n-1);
%         g = zeros(2*n-1, 1);
%         totalTime = sum(time, 2);
%         g(1:n) = rightCountInclude ./ xl - totalTime;
%         g(n+1:2*n-1) = rightCountExclude(1:n-1) ./ xp - readCount(1:n-1) ./ (1-xp);
%         g = -g ./ M;
%     end
% 
%     x = [ones(n, 1); 0.5 * ones(n-1, 1)];
%     rho = 0.5;
%     beta = 0.8;
%     
%     fprintf('itr\t|loss\t\t|g\t\t|alpha\n')
%     for itr = 1:1e4
%         f = loss(x);
%         g = gradient(x);
%         
%         alpha = 0.5;
%         while alpha > 1e-9
%             if loss(x-alpha*g) < f - rho * alpha * (g'*g)
%                 break
%             end
%             alpha = alpha * beta;
%         end
%         
%         if mod(itr, 100) == 0
%             fprintf('%d\t|%.4e\t|%.4e\t|%.4e\n', itr, f, norm(g), alpha);
%         end
%         
%         if norm(g) < 5e-4
%             break
%         end
%         
%         x = x - alpha * g;
%         x = max(x, 1e-4);
%         x(n+1:2*n-1) = min(x(n+1:2*n-1), 1-1e-4);
%     end
    
    totalTime = sum(time, 2);
    
    cvx_begin
        variables xl(n) xp(n-1)
        maximize(rightCountInclude' * log(xl) - totalTime' * xl ...
        + rightCountExclude(1:n-1)' * log(xp) + readCount(1:n-1)' * log(1-xp))
        subject to
            0 <= xl;
            0 <= xp <= 1;
    cvx_end

    lambda = xl;
    p = xp;
end

