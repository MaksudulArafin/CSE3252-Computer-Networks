	%%Find DFT of the following:   x(t)=3cos2000πt+5sin6000πt

clc;             % clear command window
clear;           % clear all variables
close all;       % close all figures

% Parameters
Fs = 10000;        % Sampling frequency (must be > 2*max freq = 6000 Hz)
T = 1/Fs;          % Sampling interval
L = 1024;          % Number of samples (DFT length)
t = (0:L-1)*T;     % Time vector

% Define signal
x = 3*cos(2000*pi*t) + 5*sin(6000*pi*t);

% Compute DFT using FFT
X = fft(x);

% Frequency axis
f = (0:L-1)*(Fs/L);   % Frequency vector (Hz)

% Plot magnitude spectrum
figure;
stem(f, abs(X)/L, 'filled'); 
xlim([0 Fs/2]);    % show only positive frequencies
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
title('Magnitude Spectrum of x(t)');
grid on;

hold on;
xline(0,'r');
yline(0,'r');
hold off;