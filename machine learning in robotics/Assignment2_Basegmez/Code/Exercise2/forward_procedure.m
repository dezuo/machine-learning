%% forward_procedure: function description
function [prob_O_given_lambda, log_prob_O_given_lambda] = forward_procedure(A, B, pi, observation_sequences)
    [M, N] = size(B);  % 8x12, #observations x #states
    [n, T] = size(observation_sequences); % 60x10, #obs_sequences x len(obs_sequence)

    prob_O_given_lambda = zeros(n, 1);

    for obs_seq=1:n
        alpha = zeros(N, T);  % 12x10

        % Initialization
        for i=1:N
            alpha(i, 1) = pi(i) * B(round(observation_sequences(obs_seq, 1)), i);
        end

        % Recursion / Induction
        for t=1:T-1
            for j=1:N
                alpha(j, t+1) = alpha(:, t)' * A(:, j) * B(observation_sequences(obs_seq, t+1), j);
            end
        end

        % Termination
        prob_O_given_lambda(obs_seq) = sum(alpha(:, T));
    end

log_prob_O_given_lambda = log(prob_O_given_lambda);
