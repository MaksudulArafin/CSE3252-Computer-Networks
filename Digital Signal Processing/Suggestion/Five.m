
%	Show that convolution of two signals in the time domain equals point-wise multiplication in the frequency domain. Given:
% x_1=[4 2 6 3 8 1 5]   and x_2=[3 8 6 9 6 7] 


	

clc; clear; close all;


% Given signals
x1 = [4 2 6 3 8 1 5];
x2 = [3 8 6 9 6 7];

% Length for linear convolution
N = length(x1) + length(x2) - 1;

% Zero-padding
x1p = [x1 zeros(1, N-length(x1))];
x2p = [x2 zeros(1, N-length(x2))];

% --- Time domain convolution ---
y_time = conv(x1, x2);

% --- Frequency domain multiplication ---
X1 = fft(x1p, N);
X2 = fft(x2p, N);
Y_freq = X1 .* X2;
y_freq = ifft(Y_freq);

disp('Time domain convolution:'), disp(y_time)
disp('Frequency domain result:'), disp(round(y_freq))
% ---------------- PLOTTING ----------------
figure;

% Plot x1 and x2
subplot(3,1,1);
stem(0:length(x1)-1, x1, 'b','LineWidth',1.5); hold on;
stem(0:length(x2)-1, x2, 'r','LineWidth',1.5);
xline(0,'k'); yline(0,'k');   % Cartesian style axes
title('Original signals x1 (blue) and x2 (red)');
xlabel('n'); ylabel('Amplitude'); grid on;

% Plot convolution result
subplot(3,1,2);
stem(0:length(y_time)-1, y_time, 'k','LineWidth',1.5);
xline(0,'k'); yline(0,'k');   % Cartesian style axes
title('Convolution in Time Domain: y\_time');
xlabel('n'); ylabel('Amplitude'); grid on;

% Plot frequency-domain result
subplot(3,1,3);
stem(0:length(y_freq)-1, real(y_freq), 'm','LineWidth',1.5);
xline(0,'k'); yline(0,'k');   % Cartesian style axes
title('Result from Frequency Domain (IFFT of X1*X2)');
xlabel('n'); ylabel('Amplitude'); grid on;
