%% EvaluateLikelihood: function description
function [LikValues] = EvaluateLikelihood(Image, mu, Sigma)
    % LikValues = ;
%     Im = imread(Image);

%     rgbValues = reshape(Im,[size(Im,1)*size(Im,2),3]);
%     rgbValues = double(rgbValues)';
%     mu = kron(mu,ones(1,size(rgbValues,2)));
%     % calculate the likelihood of the pixels to belong to the skin
%     sig_x_mu = Sigma\(rgbValues-mu);
%     x_mu = (rgbValues-mu);
%     x_mu_sigma_x_mu_vec = reshape(x_mu(:).*sig_x_mu(:),3,[])';
%     x_mu_sigma_x_mu = sum(x_mu_sigma_x_mu_vec,2);

%     LikValues = exp(-0.5.*x_mu_sigma_x_mu)./((2*pi)^(3/2)*det(Sigma));

%     LikValues = reshape(LikValues,size(Im,1),size(Im,2));

% end

    im = imread(Image);

    rgbValues = double(reshape(im, [size(im, 1)*size(im, 2), 3]))';
    mu = kron(mu, ones(1, size(rgbValues, 2)));

    x_diff = (rgbValues - mu);
    Sigma_x_diff = pinv(Sigma) * x_diff;
    exponent = sum(reshape(x_diff(:).*Sigma_x_diff(:), 3, [])', 2);
    d = 3;
    % exponent = (x_diff)' * pinv(Sigma) * x_diff;
    amplitude = 1./ sqrt((2*pi)^d*det(Sigma));
    LikValues = amplitude .* exp(-0.5 * exponent);
    LikValues = reshape(LikValues, size(im, 1), size(im, 2));

end



