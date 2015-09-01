%% functionname: function description
function [Theta] = normal_equation(X, y)
    Theta = pinv(X'*X) * X'* y;
