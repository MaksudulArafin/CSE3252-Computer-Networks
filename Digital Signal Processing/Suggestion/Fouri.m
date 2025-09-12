%Say x(n)={1,2,3,1}  , show that at 0 lag correction value is maximum

clc;
clear;

% Take input from user
x = input('Enter the sequence x(n) as a vector (e.g., [1 2 3 1]): ');

% Autocorrelation (aperiodic)
r = xcorr(x, 'none');   % 'none' = direct sum of products (no scaling)

% Define lags
lags = -(length(x)-1):(length(x)-1);

% Display results
disp('Lags:'); disp(lags);
disp('Autocorrelation values:'); disp(r);

% Show maximum value and lag
[max_val, idx] = max(r);
fprintf('Maximum autocorrelation = %d at lag = %d\n', max_val, lags(idx));

% Plot
stem(lags, r, 'filled');
xlabel('Lag');
ylabel('Autocorrelation R_x(k)');
title('Autocorrelation of Input Sequence');
grid on;
xline(0, 'r');
yline(0, 'r');