clear all;
close;
load('A.txt');
load('B.txt');
load('pi.txt');
load('A_Test_Binned.txt');
load('A_Train_Binned.txt');


[~, log_prob_train] = forward_procedure(A, B, pi, A_Train_Binned);
[~, log_prob_test] = forward_procedure(A, B, pi, A_Test_Binned);

classifications = log_prob_test > -120;

