%% Exercise3_nubs: function description
function Exercise3_nubs(gesture, K)

    [m n o] = size(gesture);

    clusters = zeros(K, size(gesture, 3));

    clusters(1, :) = [sum(sum(gesture(:, :, 1))) sum(sum(gesture(:, :, 2))) sum(sum(gesture(:, :, 3)))];
    clusters(1, :) = 1/(m*n) .* clusters(1, :);

    idx = ones(m, n);

    for k=1:K-1
        % 2 - calc cluster with highest distortion
        [max_distortion, max_cluster] = computeDistortion(gesture, idx, k, clusters);

        % 3 - split cluster into 2 subclusters
        v = rand(1, 3);
        x_a = clusters(max_cluster, :) + v;
        x_b = clusters(max_cluster, :) - v;

        % calc euc distances, assign points to subclusters
        dist1 = findDistance(gesture, x_a, idx, max_cluster);
        dist2 = findDistance(gesture, x_b, idx, max_cluster);
        idx(idx == max_cluster) = max_cluster*(dist1<=dist2) + (k+1)*(dist1>dist2);

        % 4 - update code vectors
        gesture_x = gesture(:, :, 1);
        gesture_y = gesture(:, :, 2);
        gesture_z = gesture(:, :, 3);

        g_x = sum(gesture_x(idx == max_cluster)) / sum( sum(idx == max_cluster));
        g_y = sum(gesture_y(idx == max_cluster)) / sum( sum(idx == max_cluster));
        g_z = sum(gesture_z(idx == max_cluster)) / sum( sum(idx == max_cluster));

        g_x_1 = sum(gesture_x(idx == k+1)) / sum( sum(idx == k+1));
        g_y_1 = sum(gesture_y(idx == k+1)) / sum( sum(idx == k+1));
        g_z_1 = sum(gesture_z(idx == k+1)) / sum( sum(idx == k+1));


        clusters(max_cluster, :) = [g_x g_y g_z];
        clusters(k+1, :) = [g_x_1 g_y_1 g_z_1];
    end


    color_vector = {'blue', 'black', 'red', 'green', 'magenta', 'yellow', 'cyan'};
    figure()
    hold on

    x_axis = gesture(:, :, 1);
    y_axis = gesture(:, :, 2);

    for i = 1:K
        scatter(x_axis(idx == i), y_axis(idx == i), color_vector{i});
    end

end
