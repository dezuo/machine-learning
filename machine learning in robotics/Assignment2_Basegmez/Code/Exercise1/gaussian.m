%% gaussian: function description
function [pdf] = gaussian(x, mu, sigma)
    m = size(x, 1);
    pdf = (1/((2*pi)^(m/2)*det(sigma)^0.5))*exp(-0.5*(x-mu)' * (sigma\(x-mu)));
