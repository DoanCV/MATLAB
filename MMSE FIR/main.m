clc
clear
close all

% Probability & Stochastic Processes Spring 2021
% Project #5 Part 2
% Brian Doan, Derek Lee

%% Constants

var = 1;
N = [4; 6; 10];
c = [1; 0.2; 0.4];
s = randi(2, 1000, 1)*2 -3;

%% From Part 1
Rrr_4 = [.4 + var .28 1.2 .28;
        .28 .4 + var .28 1.2;
        1.2 .28 .4 + var .28;
        .28 1.2 .28 .4 + var];
Rsr_4 = [1; .2; .4; 0];

% h_4 = inv(Rrr_4) * Rsr_4
h_4 = Rrr_4 \ Rsr_4;

Rrr_6 = [.4 + var .28 1.2 .28 0.4 0;
         0 .4 + var .28 1.2 .28 .4;
         .4 0 .4 + var .28 1.2 .28;
         .28 .4 0 .4 + var .28 1.2;
         1.2 .28 .4 0 .4 + var .28;
         .28 1.2 .28 .4 0 .4 + var];
Rsr_6 = [1; .2; .4; 0; 0; 0];

% h_6 = inv(Rrr_6) * Rsr_6
h_6 = Rrr_6 \ Rsr_6;
         
Rrr_10 = [.4 + var .28 1.2 .28 .4 0 0 0 0 0;
         0 .4 + var .28 1.2 .28 .4 0 0 0 0;
         0 0 .4 + var .28 1.2 .28 .4 0 0 0;
         0 0 0 .4 + var .28 1.2 .28 .4 0 0;
         0 0 0 0 .4 + var .28 1.2 .28 .4 0;
         0 0 0 0 0 0.4 + var .28 1.2 .28 .4;
         0.4 0 0 0 0 0 .4 + var .28 1.2 .28;
         0.28 0.4 0 0 0 0 0 .4 + var .28 1.2;
         1.2 0.28 0.4 0 0 0 0 0 .4 + var .28;
         .28 1.2 0.28 0.4 0 0 0 0 0 .4 + var];
Rsr_10 = [1; .2; .4; 0; 0; 0; 0; 0; 0; 0];

% h_10 = inv(Rrr_10) * Rsr_10
h_10 = Rrr_10 \ Rsr_10;

%% Filter Implementation

% First filter
z = filter(c, 1, s);

% Add noise
noise = normrnd(0, sqrt(var), 1000, 1);
r = z + noise;

% Second filter for three s_hats
s_hat_4 = filter(h_4, 1, r);
s_hat_6 = filter(h_6, 1, r);
s_hat_10 = filter(h_10, 1, r);

% Calculate MSE and Present in a Table
MSE = [ mean( ( s - s_hat_4 ).^2 ); mean( ( s - s_hat_6 ).^2 ); mean( ( s - s_hat_10 ).^2 ) ];
table( N, MSE )
