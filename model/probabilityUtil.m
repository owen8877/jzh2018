function g = probabilityUtil(name)
    switch name
        case 'exponential'
            g = @exponential;
        case 'uniform'
            g = @uniform;
        case 'bernoulli'
            g = @bernoulli;
        otherwise
            error('Cannot find generator of name %s.', name);
    end
end

function t = exponential(l)
    t = - log(1-rand(1, 1)) / l;
end

function t = uniform(a, b)
    t = a + rand(1, 1) * (b - a);
end

function t = bernoulli(omega)
    if rand(1, 1) < omega
        t = 1;
    else
        t = 0;
    end
end