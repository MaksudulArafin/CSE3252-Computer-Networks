%%	x(n)=u(n+5)

clc;             % clear command window
clear;           % clear all variables
close all;       % close all figures

% Define range of n
n = -10:10;        % sample range

% Define unit step shifted by -5
x = (n >= -5);     % will be 1 for n >= -5, else 0

% Plot
figure;
stem(n, x, 'filled', 'LineWidth', 1.5);
xlabel('n');
ylabel('x(n)');
title('x(n) = u(n+5)');
grid on;

hold on;
xline(0,'k');
yline(0,'k');
hold off;

