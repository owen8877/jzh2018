function steamModel = model(n, lambda, p, options)
    'steam';

    addpath('..');
    if numel(lambda) ~= n
        error('lambda should have length %d rather than %d.', n, numel(lambda));
    end
    if numel(p) ~= n
        error('p should have length %d rather than %d.', n, numel(p));
    end
    
    exponential = probabilityUtil('exponential');
    uniform = probabilityUtil('uniform');

    function [time, hint] = generate(M)
        time = zeros(n, M);
        hint = zeros(1, M);
        for i = 1:M
            for j = 1:n
                time(j, i) = exponential(lambda(j));
                if uniform(0, 1) > p(j)
                    break
                end
            end
            hint(i) = j;
        end
    end

    steamModel = @generate;
end

