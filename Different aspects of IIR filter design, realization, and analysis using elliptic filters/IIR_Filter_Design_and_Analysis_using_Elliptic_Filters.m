clear all;
close all;
clc;

%% Q1

% Filter specifications
Wp = 0.45;  % Passband edge frequency 
Ws = 0.55;  % Stopband edge frequency
Rp = 0.1;   % Passband ripple in dB
Rs = 30;    % Stopband attenuation in dB

% Design the elliptic lowpass filter
[N, Wn] = ellipord(Wp, Ws, Rp, Rs); % Calculate minimum filter order
[b, a] = ellip(N, Rp, Rs, Wn);      % Get the filter coefficients

% Frequency response
[H, w] = freqz(b, a, 1024);

% Plot magnitude response
figure;
plot(w/pi, 20*log10(abs(H)));
grid on;
title('Elliptic Lowpass Filter - Full Magnitude Response');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
ylim([-100 5]);

figure;
plot(w/pi, angle(H));
title('Elliptic Lowpass Filter - Phase Response');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Phase (radians)');
grid on;

% Plot group delay
figure
grpdelay(b, a, 1024);
title('Elliptic Lowpass Filter - Group Delay');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Group Delay (samples)');

figure;
plot(w/pi, 20*log10(abs(H)));
grid on;
title('Elliptic Lowpass Filter - Passband Magnitude Detail');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
ylim([-0.2 0.1]);

figure;
plot(w/pi, 20*log10(abs(H)));
grid on;
title('Elliptic Lowpass Filter - Transition Band Magnitude Detail');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
ylim([-5 1]);
xlim([0.4 0.5]);

figure;
plot(w/pi, 20*log10(abs(H)));
grid on;
title('Elliptic Lowpass Filter - Stopband Magnitude Detail');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
ylim([-70 -10]);
xlim([0.45 1]);

%% Q2

[d1,d2] = tf2ca(b,a); 	% TF2CA returns denominators of the allpass.
num = 0.5*conv(fliplr(d1),d2)+0.5*conv(fliplr(d2),d1);
den = conv(d1,d2); 	% Reconstruct numerator and denonimator.
MaxDiff = max([max(b-num),max(a-den)]); % Compare original and reconstructed numerator and denominators.

% Plot magnitude response
figure;
plot(w/pi, 20*log10(abs(H)));
grid on;
title('Original Filter - Magnitude Response');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
ylim([-100 5]);


[H2, w2] = freqz(num, den, 1024);

% Plot magnitude response
figure;
plot(w2/pi, 20*log10(abs(H2)));
grid on;
title('Reconstructed Filter - Magnitude Response');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
ylim([-100 5]);

% Plot group delay
figure
grpdelay(num, den, 1024);
title('Reconstructed Filter - Group Delay');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Group Delay (samples)');

figure;
[H3, w3] = freqz(num, 1, 1024);
plot(w3/pi,  angle(H2));
grid on;
title('Reconstructed Filter - Phase Response');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('angle (radians)');

figure;
[H4, w4] = freqz(den, 1, 1024);
plot(w4/pi, angle(H4));
grid on;
title('Denominator Filter - Phase Response');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('angle (radians)');

figure;
plot(w3/pi,  20*log10(abs(H3)));
grid on;
title('Numerator Filter - Magnitude Response');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');

figure;
plot(w4/pi, 20*log10(abs(H4)));
grid on;
title('Denominator Filter - Magnitude Response');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');

%% Q3

% Filter specifications
Rp = 0.1;   % Passband ripple in dB
Rs = 30;    % Stopband attenuation in dB

% Design the elliptic lowpass filter
[N2, Wn] = ellipord(Wp, Ws, Rp, Rs); % Calculate minimum filter order
[b, a] = ellip(N2, Rp, Rs, Wn);      % Get the filter coefficients

% Frequency response
[H6, w6] = freqz(b, a, 1024);
[d1,d2] = tf2ca(b,a); 	% TF2CA returns denominators of the allpass.
num2 = 0.5*conv(fliplr(d1),d2)+0.5*conv(fliplr(d2),d1);
den2 = conv(d1,d2); 	% Reconstruct numerator and denonimator.

[H7, w7] = freqz(num2, den2, 1024);

% Design the elliptic lowpass filter
[N2, Wn] = ellipord(Wp, Ws, Rp, Rs); % Calculate minimum filter order
[b, a] = ellip(N2, Rp, Rs, Wn);      % Get the filter coefficients
[bp,ap] = iirpowcomp(b, a);

[d1,d2] = tf2ca(b,a); 	% tf2ca returns denominators of the allpass.
num3 = 0.5*conv(fliplr(d1),d2)-0.5*conv(fliplr(d2),d1);
den3 = conv(d1,d2); % Reconstruct numerator and denonimator.

[H8, w8] = freqz(num3, den3, 1024);

% Plot magnitude response
figure;
plot(w6/pi, 20*log10(abs(H6)));
grid on;
title('Power Complementary Filter - Magnitude Response');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
ylim([-100 5]);

% Plot magnitude response
figure;
plot(w6/pi, angle(H6));
grid on;
title('Power Complementary Filter - Phase Response');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Phase (radians)');
ylim([-100 5]);

% Plot magnitude response for both filters
figure;
plot(w/pi, 20*log10(abs(H7)), 'b');
hold on;
plot(w/pi, 20*log10(abs(H8)), 'r');
title('Lowpass and Highpass Power Complementary Filters');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
legend('Lowpass Filter', 'Highpass Filter');
grid on;
ylim([-100 5]);

%% Q4

[allpass1, allpass2] = tf2ca(b, a);

% Convert each allpass section to lattice form using tf2latc
[k1, v1] = tf2latc(allpass1, 1);  % Allpass section 1
[k2, v2] = tf2latc(allpass2, 1);  % Allpass section 2

% Display lattice coefficients for each allpass section
disp('Lattice coefficients for Allpass Section 1:');
disp(k1);

disp('Reflection coefficients for Allpass Section 1 (v1):');
disp(v1);

disp('Lattice coefficients for Allpass Section 2:');
disp(k2);

disp('Reflection coefficients for Allpass Section 2 (v2):');
disp(v2);

%% Q5
[N, Wn] = ellipord(Wp, Ws, Rp, Rs);
[b, a] = ellip(N, Rp, Rs, Wn);

% Frequency response of the original filter (without quantization)
[H_orig, w] = freqz(b, a, 1024);

% Step 2: Quantize Direct Form Coefficients

% 16-bit quantization
b_quant16 = quantize(b, 15);
a_quant16 = quantize(a, 15);
[H_quant16, w] = freqz(b_quant16, a_quant16, 1024);

% 10-bit quantization
b_quant10 = quantize(b, 9);
a_quant10 = quantize(a, 9);
[H_quant10, w] = freqz(b_quant10, a_quant10, 1024);

% Step 3: Convert to lattice form and quantize lattice coefficients
[k, v] = tf2latc(b, a);  % Lattice realization

% Quantize the lattice coefficients to 16 bits and 10 bits
k_quant16 = quantize(k, 16);
v_quant16 = quantize(v, 16);
k_quant10 = quantize(k, 10);
v_quant10 = quantize(v, 10);

% Convert back to direct form using the quantized lattice coefficients
[b_lattice16, a_lattice16] = latc2tf(k_quant16, v_quant16);
[b_lattice10, a_lattice10] = latc2tf(k_quant10, v_quant10);

% Frequency response of the quantized lattice form filters
[H_lattice16, w] = freqz(b_lattice16, a_lattice16, 1024);
[H_lattice10, w] = freqz(b_lattice10, a_lattice10, 1024);

% Step 4: Plot and Compare Frequency Responses
figure;
plot(w/pi, 20*log10(abs(H_orig)), 'b*');
hold on;
plot(w/pi, 20*log10(abs(H_quant16)), 'r--');
plot(w/pi, 20*log10(abs(H_lattice16)), 'g+');
title('Quantization Effects Comparison (16-bit)');
legend('Original', 'Direct Form 16-bit', 'Lattice Form 16-bit');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
grid on;

figure;
plot(w/pi, 20*log10(abs(H_orig)), 'b*');
hold on;
plot(w/pi, 20*log10(abs(H_quant10)), 'r--');
plot(w/pi, 20*log10(abs(H_lattice10)), 'g+');
title('Quantization Effects Comparison (10-bit)');
legend('Original','Direct Form 10-bit', 'Lattice Form 10-bit');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
grid on;