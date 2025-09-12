%%	Find DFT of the following:   x(t)=3cos2000πt+5sin6000πt

clc;             % clear command window
clear;           % clear all variables
close all;       % close all figures

% Parameters
fs = 8000;              % Sampling frequency (Hz)
N = 1024;               % Number of points for DFT
t = (0:N-1)/fs;         % Time samples

% Signal definition: x(t) sampled
x = 3*cos(2*pi*1000*t) + 5*sin(2*pi*3000*t);

% Compute DFT using FFT
X = fft(x, N);

% Frequency axis (in Hz)
f = (0:N-1)*(fs/N);

% Plot magnitude spectrum
figure;
plot(f, abs(X), 'LineWidth', 1.5); % abs because DFT bin can't be negetive
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Magnitude Spectrum of x(t)');
grid on;
xlim([0 fs/2]);   % Show only up to Nyquist frequency
hold on;
xline(0,'r');
yline(0,'r');
hold off;