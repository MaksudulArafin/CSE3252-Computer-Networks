%Generate a signal, x(n)=sin⁡(2π10t+45°), then show the discrete time signal using sampling frequency 50Hz

clc;
clear;

fs = 50;                  % Sampling frequency
t = 0:1/1000:1;           % Continuous time vector (1 sec)
N = 50;                   % Number of discrete samples
n = 0:N-1;                % Discrete sample indices

% Discrete-time signal
x = sin(2*pi*10*n/fs + pi/4);

% Continuous-time signal
y = sin(2*pi*10*t + pi/4);

% Create figure with subplots
figure;

% Subplot 1: Continuous-time signal
subplot(2,1,1);
plot(t, y, 'k', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Continuous-time Signal x(t)');
grid on;
xline(0, 'r');
yline(0, 'r');

% Subplot 2: Discrete-time signal
subplot(2,1,2);
stem(n/fs, x, 'g', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Amplitude');
title('Discrete-time Signal x[n]');
grid on;
xline(0, 'r');
yline(0, 'r');

