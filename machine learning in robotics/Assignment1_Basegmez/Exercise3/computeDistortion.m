%% computeDistortion: function description
function [max_distortion, max_cluster] = computeDistortion(X, idx, K, clusters)
    for k=1:K
        cluster_vectors = idx == k; % 60x10
        distortion(k) = 0;

        for i=1:size(cluster_vectors, 1)
            for j=1:size(cluster_vectors, 2)
                if cluster_vectors(i, j) == 1
                    point = X(i, j, :);
                    point = reshape(point, size(point, 2), size(point, 3));
                    euclidean_distance = sqrt(sum(point - clusters(k), 2));
                    distortion(k) = distortion(k) + euclidean_distance;
                end
            end
        end
    end

    [max_distortion, max_cluster] = max(distortion);

