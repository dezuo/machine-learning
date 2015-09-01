%% findDistances: function description
function [distance] = findDistance(gesture, x, idx, max_cluster)

    g_x = gesture(:, :, 1);
    g_y = gesture(:, :, 2);
    g_z = gesture(:, :, 3);
    diff_x = g_x(idx == max_cluster) - x(1);
    diff_y = g_y(idx == max_cluster) - x(2);
    diff_z = g_z(idx == max_cluster) - x(3);
    distance = sqrt(diff_x.^2 + diff_y.^2 + diff_z.^2);



end
