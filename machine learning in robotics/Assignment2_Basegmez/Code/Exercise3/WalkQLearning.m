%% WalkQLearning: function description
function WalkQLearning(s)

    % Q = zeros(length(state), length(action));
    Q = zeros(16, 4);
    T = 8000;  % #steps

    epsilon = 0;
    gamma = 0.5;
    alpha = 0.5;
    state = s;

    for t=1:T
        action = epsilon_greedy(Q, state, epsilon);
        [newstate, reward] = SimulateRobot(state, action);
        Q(state, action) = Q(state, action) + alpha * (reward + gamma * max(Q(newstate, :)) - Q(state, action));
        state = newstate;

    end

    [~, policy] = max(Q, [], 2);

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

    states = zeros(16, 1);
    states(1) = s;
    for i=2:16
        states(i) = delta(states(i-1), policy(states(i-1)));
    end

    walkshow(states')

end
