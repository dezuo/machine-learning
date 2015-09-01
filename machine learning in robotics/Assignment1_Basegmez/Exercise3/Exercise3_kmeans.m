%% Exercise3_kmeans: function description
function Exercise3_kmeans(gesture, init_cluster, K)

    epsilon = 1e-6;

    current_error = 0;
    last_err = inf;

    while ((last_err - current_error) > epsilon)
    % for i=1:3
        % find closest centroids
        idx = findClosestCentroids(gesture, init_cluster); % 60x10

        % given the memberships, compute new centroids
        [init_cluster, total_distortion] = computeCentroids(gesture, idx, K);

        last_err = current_error;
        current_error = current_error + total_distortion;
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
