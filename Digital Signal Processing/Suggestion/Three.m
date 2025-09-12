%Generate a signal, x(n)=sin⁡(2π10t+45°), then show the discrete time signal using sampling frequency 50Hz

clc;
clear;
close all;

fs = 50;                  % Sampling frequency
t = 0:1/1000:1;           % Continuous time vector (1 sec)
N = 50;                    % Number of discrete samples
n = 0:N-1;                 % Discrete sample indices

% Discrete-time signal
x = sin(2*pi*10*n/fs + pi/4);

% Continuous-time signal
y = sin(2*pi*10*t + pi/4);

% Plot both together
figure;
plot(t, y, 'k', 'LineWidth', 1.5);  % Continuous-time signal
hold on;
stem(n/fs, x, 'g', 'LineWidth', 1.5); % Discrete-time samples (convert n->t)
xlabel('Time (s)');
ylabel('Amplitude');
title('Continuous and Discrete-Time Signal');
legend('Continuous-time x(t)', 'Discrete-time x[n]');
grid on;

% Optional: axes lines
xline(0, 'r');
yline(0, 'r');
hold off;
