clc;
clear;
close all;

% Define range
n = -10:10;               % sample indices
r = n .* (n >= 0);        % unit ramp: n for n>=0, 0 otherwise .* means element-by-element multiplication (also called dot multiplication). 

% Plot
stem(n, r, 'filled');
xlabel('n');
ylabel('r[n]');
title('Unit Ramp Signal');
grid on;
xline(0, 'r');
yline(0, 'r');

