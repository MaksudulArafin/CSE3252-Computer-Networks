clc;             % clear command window
clear;           % clear all variables
close all;       % close all figure


% Define the range of n
n = -5:5;          % from -5 to 5 (you can adjust)

% Define delta function
x = (n == 2);      % δ(n-2) --> 1 only when n=2, otherwise 0

% Plot
stem(n, x, 'filled');
xlabel('n');
ylabel('x(n)');
title('x(n) = \delta(n-2)');
grid on;


hold on;
xline(0,'r');
yline(0,'r');
hold off;