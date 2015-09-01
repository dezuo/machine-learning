function idx = findClosestCentroids(X, centroids)
%FINDCLOSESTCENTROIDS computes the centroid memberships for every example
%   idx = FINDCLOSESTCENTROIDS (X, centroids) returns the closest centroids
%   in idx for a dataset X where each row is a single example. idx = m x 1
%   vector of centroid assignments (i.e. each entry in range [1..K])
%

    for centroid_idx = 1:size(centroids, 1) % 7 centroids
        for axis_idx = 1:size(centroids, 2) % 3 axes
            centroid = centroids(centroid_idx, axis_idx); % 1x1
            example = X(:, :, axis_idx); % 60x10
            square_distances(:, :, axis_idx) = (example - centroid).^2; % 60x10
        end
        euclidean_distances(:, :, centroid_idx) = sqrt(sum(square_distances, 3));
    end

    [~, idx] = min(euclidean_distances, [], 3);


% =============================================================

end

