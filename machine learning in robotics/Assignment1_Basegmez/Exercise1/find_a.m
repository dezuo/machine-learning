%% find_a: function description
function [a] = find_a(input_training, output_training, p)

    input_training = create_polynomial(input_training, p);
    a = normal_equation(input_training, output_training);

end
