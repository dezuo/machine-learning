function [centroids, total_distortion] = computeCentroids(X, idx, K)

[m n o] = size(X);

centroids = zeros(K, o);

% for i = 1:K
%     cluster_vectors = idx == i;
%     amount_of_vectors = sum(cluster_vectors);
%     sum_of_vectors = cluster_vectors' * X;
%     centroids(i, :) = sum_of_vectors ./ amount_of_vectors;
% end


for k = 1:K
    cluster_vectors = idx == k;
    amount_of_vectors = sum(cluster_vectors(:));
    mean_of_vectors = reshape(sum(bsxfun(@times, cluster_vectors, X)), n, o) ./ amount_of_vectors;  % 10 x 3
    sum_of_vectors = sum(bsxfun(@times, cluster_vectors, X));
    sum_of_vectors = reshape(sum_of_vectors, n, o);
    point_mean = sum(mean_of_vectors) / n;
    centroids(k, :) = point_mean;
end

% for k = 1:K
%     cluster_vectors = idx == k; % 60 x 10, 0 and 1's.
%     distortion(k) = 0;

%     for i=1:size(cluster_vectors, 1)
%         for j=1:size(cluster_vectors, 2)
%             if cluster_vectors(i, j) == 1
%                 point = X(i, j, :);
%                 point = reshape(point, size(point, 2), size(point, 3)); % 1 x 3 point
%                 point_centroid_diff = point - centroids(k);
%                 euclidean_distance = sqrt(sum(point_centroid_diff.^2, 2));
%                 distortion(k) = distortion(k) +  euclidean_distance;
%             end
%         end
%     end
% end

% total_distortion = sum(distortion);

    for k=1:K
        cluster_vectors = idx == k; % 60x10
        distortion(k) = 0;

        for i=1:size(cluster_vectors, 1)
            for j=1:size(cluster_vectors, 2)
                if cluster_vectors(i, j) == 1
                    point = X(i, j, :);
                    point = reshape(point, size(point, 2), size(point, 3));
                    euclidean_distance = sqrt(sum(point - centroids(k), 2));
                    distortion(k) = distortion(k) + euclidean_distance;
                end
            end
        end
    end

    total_distortion = sum(distortion);

end

