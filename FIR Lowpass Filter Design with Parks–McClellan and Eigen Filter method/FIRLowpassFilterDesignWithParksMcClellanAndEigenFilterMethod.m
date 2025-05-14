clear all;
close all;
clc;

%% Q1
% Specifications
wp = 0.6*pi;  % Passband edge frequency
ws = 0.5*pi;  % Stopband edge frequency
Rp = 1;       % Passband ripple (dB)
Rs = 40;      % Stopband attenuation (dB)

% Normalized frequencies (between 0 and 1)
fp = wp/pi;  % Passband edge in normalized frequency
fs = ws/pi;  % Stopband edge in normalized frequency

% Estimate the filter order
[N, fo, ao, w] = firpmord([fs fp], [0 1], [10^(-Rs/20) (10^(Rp/20)-1)/(10^(Rp/20)+1)]);

% Design the FIR filter using Parks-McClellan algorithm
b = firpm(N, fo, ao, w);

% Impulse response plot
figure;
stem(b);
title('Impulse Response');
xlabel('Samples');
ylabel('Amplitude');
grid on;

% Frequency response plot
[H,f] = freqz(b,1,1024);  % Frequency response
mag = abs(H);
db = 20*log10(mag);  % Magnitude in dB

figure;
plot(f/pi, db);
title('Frequency Response (Magnitude in dB)');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
grid on;
xlim([0 0.6]);
ylim([-40.5 -39.5]);
% xlim([0.55 1]);
% ylim([-1.5 1.5]);

% Specification template (Passband and Stopband boundaries)
yline(-Rs, 'r--', 'Stopband Spec (-40 dB)');
xline(fs, 'r--', '\omega_s = 0.5\pi');
xline(fp, 'g--', '\omega_p = 0.6\pi');
yline(-Rp, 'b--');
yline(Rp, 'b--');
legend('Magnitude response', 'Stopband Spec', '\omega_s', '\omega_p', 'Passband Spec');


%% Q2

alpha1 = 0.2;
alpha2 = 0.5;
N = 30;

b1 = eigen_filter(alpha1);
[Hb1, w] = freqz(b1, 1, 1024);

b2 = eigen_filter(alpha2);
[Hb2, ~] = freqz(b2, 1, 1024);


%% for alpha1
% Comparison with firls (least-squares design)
% Design using firls with the same specifications
h_firls = firls(N-1, [0, 0.3, 0.5, 1], [1, 1, 0, 0]);
[H_firls, w] = freqz(h_firls, 1, 1024);

% Plot comparison for the first alpha value
figure;
plot(w/pi, 20*log10(abs(Hb1)));
hold on;
plot(w/pi, 20*log10(abs(Hb2)));
plot(w/pi, 20*log10(abs(H_firls)));
title('Comparison of Eigenfilter and FIRLS (Magnitude Response)');
legend('Eigenfilter (\alpha = 0.2)','Eigenfilter (\alpha = 0.5)',  'FIRLS');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
grid on;
% xlim([0 0.35]);
% ylim([-0.03 0.03]);
% xlim([0.47 0.9]);
% ylim([-85 -45]);

% Plot the impulse responses
figure;
stem(b1);
hold on;
stem(b2);
stem(h_firls, 'r--');
title('Comparison of Impulse Responses');
legend('Eigenfilter (\alpha = 0.2)', 'Eigenfilter (\alpha = 0.5)', 'FIRLS');
xlabel('n');
ylabel('h[n]');
grid on;


function b = eigen_filter(alpha)
% eigen_filter designs a Type I lowpass eigenfilter using normalized
% frequency (in pi rad/sample).
%
% Input:
% wp    - Passband edge frequency (in radians), e.g., 0.3*pi
% ws    - Stopband edge frequency (in radians), e.g., 0.5*pi
% alpha - Weighting factor between passband and stopband errors (0 ≤ alpha ≤ 1)
% N     - Filter order (must be even for Type I filters)
%
% Output:
% b     - FIR filter coefficients
%

wp = 0.3*pi;
ws = 0.5*pi;
N = 30;
M = N/2;

% Step 1: Compute Ps (Stopband error matrix)
Ps = zeros(M+1);
for i = 0:M
    Cw_CwT = @(w) cos(i*w) * cos((0:M)*w);
    Ps(i+1, :) = 1/pi * integral(Cw_CwT, ws, pi, 'ArrayValued', true);
end

% Step 2: Compute Pp (Passband error matrix)
Pp = zeros(M+1);
for i = 0:M
    Cw_CwT = @(w) (1 - cos(i*w)) * (1 - cos((0:M)*w));
    Pp(i+1, :) = 1/pi * integral(Cw_CwT, 0, wp, 'ArrayValued', true);
end

% Step 3: Create weighted combination of Ps and Pp
P = alpha * Ps + (1 - alpha) * Pp;

% Step 4: Compute eigenvector corresponding to the smallest eigenvalue
[V, D] = eig(P);
[~, k] = min(diag(D));
b_half = -0.5 * V(:, k);

% Step 5: Construct the full filter coefficient vector
b = [flipud(b_half(2:end)); 2*b_half(1); b_half(2:end)];
b = b ./ sum(b); % Normalize the filter coefficients

% Impulse response plot
figure;
stem(b);
title('Impulse Response:: \alpha=', num2str(alpha));
xlabel('Samples');
ylabel('Amplitude');
grid on;

% Frequency response plot
[H, w] = freqz(b, 1, 1024);  % Frequency response
db = 20*log10(abs(H));  % Magnitude in dB

figure;
plot(w/pi, db);
title('Frequency Response:: \alpha=', num2str(alpha));
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
grid on;
% xlim([0 0.35]);
% ylim([-0.05 0.05]);
xline(ws/pi, 'r--', '\omega_s = 0.5\pi');
xline(wp/pi, 'g--', '\omega_p = 0.3\pi');
legend('magnitude response', '\omega_s', '\omega_p');
% xlim([0 0.6]);
% ylim([-40.5 -39.5]);
% xlim([0.55 1]);
% ylim([-1.5 1.5]);

end