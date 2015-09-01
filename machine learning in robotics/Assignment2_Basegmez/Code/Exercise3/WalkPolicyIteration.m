%% WalkPolicyIteration: function description
function WalkPolicyIteration(s)
    epsilon = 0.001;
    gamma = 0.99;
    rew = zeros(16, 4);

    reward = 1;
    punishment = -10;

    rew = [
        0, 0, 0, 0;
        0, 0, 0, 0;
        0, 0, 0, 0;
        0, 0, 0, 0;
        0, 0, 0, 0;
        0, 0, 0, 0;
        0, 0, 0, 0; %7
        0, reward, 0, 0; %8
        0, 0, 0, 0;
        0, 0, 0, 0; %10
        0, 0, 0, 0;
        0, reward, 0, 0; %12
        0, 0, 0, 0;
        0, 0, 0, reward;
        0, 0, 0, reward;
        0, 0, 0, 0;
    ];

    pun = [
        0, 0, 0, 0;
        0, 0, punishment, punishment;
        0, 0, punishment, punishment;
        0, 0, 0, 0;
        punishment, punishment, 0, 0;
        0, 0, 0, 0; %6
        0, 0, 0, 0;
        punishment, 0, 0, 0;
        punishment, punishment, 0, 0;
        0, 0, 0, 0;
        0, 0, 0, 0;
        punishment, 0, 0, 0;
        0, 0, 0, 0;
        0, 0, punishment, 0;
        0, 0, punishment, 0;
        0, 0, 0, 0;
    ];

    rew = rew + pun;

    delta = [
        2, 4, 5, 13;
        1, 3, 6, 14;
        4, 2, 7, 15;
        3, 1, 8, 16;
        6, 8, 1, 9;
        5, 7, 2, 10;
        8, 6, 3, 11;
        7, 5, 4, 12;
        10, 12, 13, 5;
        9, 11, 14, 6;
        12, 10, 15, 7;
        11, 9, 16, 8;
        14, 16, 9, 1;
        13, 15, 10, 2;
        16, 14, 11, 3;
        15, 13, 12, 4;
    ];

    [num_states, num_actions] = size(rew);
    policy = ceil(rand(num_states, 1)*4);

    iteration = 0;
    while true
        iteration = iteration + 1;

        % calculate value-function using Bellmann-Eq.
        A = eye(num_states); % 16x16
        b = zeros(num_states, 1);
        b = diag(rew(:, policy));
        col_idx = diag(delta(:, policy));
        row_idx = linspace(1,num_states, num_states)';
        indices = sub2ind(size(A),row_idx,col_idx);
        A(indices) = -gamma;
        V_pi = A\b;

        % update policy
        [~, policy_new] = max((rew + V_pi(delta)), [], 2);

        % check convergence
        if norm(policy_new-policy) <= (epsilon * (1-gamma) / gamma)
            break;
        else
            policy = policy_new;
        end
    end

    iteration
    states = zeros(num_states, 1);
    states(1) = s;
    for i=2:num_states
        states(i) = delta(states(i-1), policy(states(i-1)));
    end

    walkshow(states')

end
