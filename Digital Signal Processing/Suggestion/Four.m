	%Say x(n)={1,2,3,1}  , show that at 0 lag correction value is maximum.

    clc;
clear;

% Define sequence
x = [1 2 3 1];

% Autocorrelation (aperiodic)
r = xcorr(x, 'biased');   % 'biased' or 'unbiased' just scales; try 'none' for raw sum

% Define lags
lags = -(length(x)-1):(length(x)-1);

% Display results
disp('Lags:'); disp(lags);
disp('Autocorrelation values:'); disp(r);

% Plot
stem(lags, r, 'filled');
xlabel('Lag');
ylabel('Autocorrelation R_x(k)');
title('Autocorrelation of x(n) = {1,2,3,1}');
grid on;

xline(0, 'r');
yline(0, 'r');