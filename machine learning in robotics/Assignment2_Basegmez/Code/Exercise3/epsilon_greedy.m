%% epsilon_greedy: function description
function [new_action] = epsilon_greedy(Q, state, epsilon)
    % 1-epsilon of the time
    % new_state = argmax Q(s, a)

    % epsilon of the time
    % new_state = random(Q)

    prob = rand;  % uniform 0..1
    % if prob > epsilon
    %     [~, new_action] = max(Q(state, :));
    % else  % less than epsilon
    %     % new_action = Q(state, randperm(size(Q, 2), 1)); % this randomly picks from Q(state, :). but the index of that value is required.
    %     new_action = randperm(size(Q, 2), 1);  % randomly select action
    % end

    x=sum(prob>=cumsum([0, 1-epsilon, epsilon]));

    if x == 1
        [~, new_action] = max(Q(state, :));
    else
        % new_action = datasample(linspace(1,size()))
        new_action = randperm(size(Q, 2), 1);
    end
