%% Exercise1: function description
function par = Exercise1(k)
    load('Data.mat');
    Input = Input';
    Output = Output';

    p = [1:6];

    n = length(Input);
    amount_of_cv_samples = floor(n/k);

    for K=1:k
        cv_indices = [1+(K-1)*amount_of_cv_samples:K*amount_of_cv_samples];

        input_training = Input;
        input_cv = Input(cv_indices, :);
        input_training(cv_indices, :) = [];

        output_training = Output;
        output_cv = Output(cv_indices, :);
        output_training(cv_indices, :) = [];

        [pos_err(:, K), ori_err(:, K)] = find_errors_for_all_p(input_training, output_training, input_cv, output_cv, p);

    end

    [x, p1_best] = min(mean(pos_err,2));
    [y, p2_best] = min(mean(ori_err,2));
    [x, y]
    [p1_best, p2_best]

    a_p1 = find_a(Input, Output, p1_best);
    a_p2 = find_a(Input, Output, p2_best);

    a_x = a_p1(:, 1);
    a_y = a_p1(:, 2);
    a_theta = a_p2(:, 3);


    par{1} = a_x;
    par{2} = a_y;
    par{3} = a_theta;

    if k == 5
        save('params','par');
        Simulate_robot(0, 0.05);
        Simulate_robot(1, 0);
        Simulate_robot(1, 0.05);
        Simulate_robot(-1, -0.05);
        % Simulate_robot(0.5, -0.03);
    end

end
