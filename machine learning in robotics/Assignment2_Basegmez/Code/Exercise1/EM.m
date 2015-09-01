clear;
load('data1.mat'); %Data = 3x300, x0=index, x1,x2 are content.

[m, n] = size(Data); % #features_per_vector #feature vectors
K = 4;  % #mixtures
m = m-1;  % only 2 features (x, y) of 3. third data is just the index
X = Data(2:3, :);

%Init

[idx, C] = kmeans(X', K);

prob = zeros(K, 1);  % prob is pi_j
sigma = zeros(K*2, 2);

for j=1:K
    cluster = Data(2:3, idx == j);
    prob(j) = size(cluster, 2)/n;  % init as n_j/n
    sigma(2*j-1:2*j, :) = cov(cluster'); % init as cov(x_j)
end

p_wk_given_xi_theta = zeros(K, n);
log_theta = 0;

for i=1:n
    arg_log = 0;
    for k=1:K
        arg_log = arg_log + prob(k) * gaussian(X(:, i), C(k, :)', sigma(2*k-1:2*k, :));
    end
    log_theta = log_theta + log(arg_log);
end


while true
    % E-Step
    for k=1:K
        for i=1:n
            denom = 0;
            for j=1:K
                denom = denom + prob(j) * gaussian(X(:, i), C(j, :)', sigma(2*j-1:2*j, :));
            end

            p_wk_given_xi_theta(k, i) = prob(k) * gaussian(X(:, i), C(k, :)', sigma(2*k-1:2*k, :)) / denom;
        end
    end

    % M-Step
    n_k = sum(p_wk_given_xi_theta, 2);
    for k=1:K
        % assign new C and prob
        C(k, :) = 1/n_k(k) .* [p_wk_given_xi_theta(k, :) * X(1, :)'; p_wk_given_xi_theta(k, :) * X(2, :)']';
        prob(k) = n_k(k) / n;
        nom = zeros(2, 2);
        for i=1:n
            nom = nom + p_wk_given_xi_theta(k, i) .* ((X(:, i) - C(k, :)') * (X(:, i) - C(k, :)')');
        end

        % assign new sigma
        sigma(2*k-1:2*k, :) = (1/n_k(k)) .* nom;
    end

    % Convergence check
    log_theta_new = 0;
    for i=1:n
        arg_log = 0;
        for k=1:K
            arg_log = arg_log + prob(k) * gaussian(X(:, i), C(k, :)', sigma(2*k-1:2*k, :));
        end
        log_theta_new = log_theta_new + log(arg_log);
    end

    if abs(log_theta_new - log_theta) < 0.1
        break;
    else
        log_theta = log_theta_new;
    end
end

prob
C
sigma



