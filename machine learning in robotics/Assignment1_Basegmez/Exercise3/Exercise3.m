clear all;
load('gesture_dataset.mat');

K = 7; % #clusters

% Exercise3_kmeans(gesture_l, init_cluster_l, K);
% Exercise3_kmeans(gesture_o, init_cluster_o, K);
% Exercise3_kmeans(gesture_x, init_cluster_x, K);

Exercise3_nubs(gesture_l, K);
Exercise3_nubs(gesture_o, K);
Exercise3_nubs(gesture_x, K);
