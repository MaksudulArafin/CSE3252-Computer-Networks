% Time specifications
Fs = 2000;              % Sampling frequency (at least 2x100 = 200 Hz, but choose higher for smoothness)
T = 1/Fs;               % Sampling period
L = 200;                % Number of samples
t = (0:L-1)*T;          % Time vector

% Signal
x = 5*cos(2*pi*100*t);

% Plot
figure;
plot(t, x, 'b', 'LineWidth', 1.5);  %plot(x, y, 'b', 'LineWidth', 1.5, 'Marker', 'o')
xlabel('Time (seconds)');
ylabel('Amplitude');
title('x(t) = 5cos(2π100t)');
grid on;

% Cartesian style axes
hold on;
xline(0, 'r');   % y-axis    'r'=red
yline(0, 'r');   % x-axis     'k'=black
hold off;