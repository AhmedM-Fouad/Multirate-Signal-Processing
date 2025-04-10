clear all;
close all;
clc;

% Specs with normalized frequencies
wp1 = 0.3;
wp2 = 0.7;
ws1 = 0.2;
ws2 = 0.8;

% Gain params
Gp = 0.99; % Passband ripple
Gs = 0.01; % Stopband attenuation

% Convert gains to dB scale
Rp = -20 * log10(Gp); % Passband ripple
Rs = -20 * log10(Gs); % Stopband attenuation

% Determine the minimum order for the Elliptic filter
[N, Wn] = ellipord([wp1 wp2], [ws1 ws2], Rp, Rs);

% Design the bandpass Elliptic filter
[a, b] = ellip(N, Rp, Rs, Wn, 'bandpass');

% Convert to Second-Order Sections (SOS)
[sos, g] = tf2sos(a, b);

% Create magnitude response plot (zoomed in dB scale)
figure;
[h, w] = freqz(sos, 1024);
mag = 20*log10(abs(h));
plot(w/pi, mag);
title('Magnitude Response (dB)');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
grid on;
xlim([0 1]); % Show full normalized frequency range
ylim([-100 30]); % Set appropriate dB range

% Add passband/stopband indicators
hold on;
plot([wp1 wp1], ylim, 'r--'); % Lower passband edge
plot([wp2 wp2], ylim, 'r--'); % Upper passband edge
plot([ws1 ws1], ylim, 'g--'); % Lower stopband edge
plot([ws2 ws2], ylim, 'g--'); % Upper stopband edge
hold off;
legend('Response', 'Passband edges', 'Stopband edges', 'Location', 'best');

% Plot group delay
figure;
grpdelay(sos, 1024); % Group delay with 1024 points
title('Group Delay of the Filter');
grid on;

% Display the SOS coefficients
disp('Second-Order Sections (SOS) Coefficients:');
disp(sos);

% Display first order section coefficients
disp('First-Order Section Coefficients:');
disp('Numerator:');
disp(a);
disp('Denominator:');
disp(b);