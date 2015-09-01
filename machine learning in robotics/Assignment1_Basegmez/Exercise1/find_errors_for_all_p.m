%% find_errors_for_all_p: function description
function [pos_err, orr_err] = find_errors_for_all_p(Input_training, Output_training, Input_cv, Output_cv, p_values)

    for p = p_values
        a = find_a(Input_training, Output_training, p);
        input_cv = create_polynomial(Input_cv, p);
        Output_predicted = input_cv * a;
        [pos_err(p, :), orr_err(p, :)] = calculate_prediction_errors(Output_cv, Output_predicted);
    end
end
