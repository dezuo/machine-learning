%% calculate_prediction_errors: function description
function [position_error, orientation_error] = calculate_prediction_errors(Output, Output_predicted)
    square_error =  (Output-Output_predicted).^2;
    x2 = square_error(:, 1);
    y2 = square_error(:, 2);
    theta2 = square_error(:, 3);

    position_error = mean(sqrt(x2 + y2));
    orientation_error = mean(sqrt(theta2));
end
