%% create_polynomial: function description
function [polynomial] = create_polynomial(input, p)
    v = input(:, 1);
    w = input(:, 2);
    polynomial_terms = [v w v.*w];

    x = ones(length(input), 1);

    for i=1:p
        tmp = polynomial_terms.^i;
        x = [x tmp];
    end

    polynomial = x;

end
