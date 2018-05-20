function meituanModel = model(n, lambda, p, omega, options)
    'meituan';
    
    addpath('..');
    if numel(lambda) ~= n
        error('lambda should have length %d rather than %d.', n, numel(lambda));
    end
    if numel(p) ~= n
        error('p should have length %d rather than %d.', n, numel(p));
    end
    if numel(omega) ~= n
        error('omega should have length %d rather than %d.', n, numel(omega));
    end
    
    exponential = probabilityUtil('exponential');
    uniform = probabilityUtil('uniform');
    bernoulli = probabilityUtil('bernoulli');

    function [time, hint, skip] = generate(M)
        time = zeros(n, M);
        hint = zeros(1, M);
        skip = zeros(n, M);
        for i = 1:M
            for j = 1:n
                if bernoulli(omega(j))
                    skip(j, i) = 1;
                    continue;
                else
                    skip(j, i) = 0;
                end
                time(j, i) = exponential(lambda(j));
                if uniform(0, 1) > p(j)
                    break
                end
            end
            hint(i) = j;
        end
    end

    meituanModel = @generate;
end

