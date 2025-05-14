clear all;
close all;
clc;

% Given specifications
M = 5;
delta_omega = pi/100;
omega_p = pi/M - delta_omega;
omega_s = pi/M + delta_omega;
Rp = 1;    % Passband ripple in dB
Rs = 30;   % Stopband attenuation in dB

% Normalize frequencies to [0, 1] (relative to Nyquist frequency)
f_p = omega_p / pi;  % Normalized passband edge
f_s = omega_s / pi;  % Normalized stopband edge

% Parks-McClellan algorithm design
n = 221;
b = firpm(n, [0 f_p f_s 1], [1 1 0 0], [10^(Rp/20) 10^(-Rs/20)]);

% Check and plot the results
% Impulse response
figure;
stem(b);
title('Impulse Response');
xlabel('Samples');
ylabel('Amplitude');
grid on;

% Frequency response
[H, W] = freqz(b, 1, 1024);
H_mag = 20*log10(abs(H));

% Plot full frequency response
figure;
plot(W/pi, H_mag);
title('Frequency Response Magnitude');
xlabel('Normalized Frequency (\times \pi rad/sample)');
ylabel('Magnitude (dB)');
grid on;
hold on;

% Specification template (overall response)
plot([0 f_p], [-Rp -Rp], 'r--');  % Passband ripple limit
plot([f_s 1], [-Rs -Rs], 'r--');  % Stopband attenuation limit
plot([f_p f_p], [-Rs 0], 'g--');  % Passband edge
plot([f_s f_s], [-Rs 0], 'g--');  % Stopband edge

legend('Frequency Response', 'Passband Ripple Limit', 'Stopband Attenuation Limit', 'Passband Edge', 'Stopband Edge');
hold off;

% Zoomed-in plot for passband
figure;
plot(W/pi, H_mag);
title('Zoomed-in Passband Magnitude Response');
xlabel('Normalized Frequency (\times \pi rad/sample)');
ylabel('Magnitude (dB)');
grid on;
xlim([0 f_p+0.05]);  % Limit to passband region
ylim([-Rp-1 1]);  % Set limits to show ripple clearly

% Passband specification template
hold on;
plot([0 f_p], [-Rp -Rp], 'r--');  % Passband ripple limit
plot([f_p f_p], [-Rp 1], 'g--');  % Passband edge
legend('Frequency Response', 'Passband Ripple Limit', 'Passband Edge');
hold off;

% Zoomed-in plot for stopband
figure;
plot(W/pi, H_mag);
title('Zoomed-in Stopband Magnitude Response');
xlabel('Normalized Frequency (\times \pi rad/sample)');
ylabel('Magnitude (dB)');
grid on;
xlim([f_s-0.05 1]);  % Limit to stopband region
ylim([-Rs-10 -Rs+10]);  % Set limits to show attenuation clearly

% Stopband specification template
hold on;
plot([f_s 1], [-Rs -Rs], 'r--');  % Stopband attenuation limit
plot([f_s f_s], [-Rs-10 -Rs+10], 'g--');  % Stopband edge
legend('Frequency Response', 'Stopband Attenuation Limit', 'Stopband Edge');
hold off;

%% Q2

% Polyphase decomposition (Type I polyphase)
% Polyphase component E_k corresponds to every M-th coefficient starting at k
polyphase_sections = cell(1, M);
for k = 1:M
    polyphase_sections{k} = b(k:M:end);
end

% Plot the magnitude and phase response for each polyphase section
for k = 1:M
    [H_poly, W_poly] = freqz(polyphase_sections{k}, 1, 1024);
    
    % Magnitude response
    figure;
    subplot(2, 1, 1);
    plot(W_poly/pi, 20*log10(abs(H_poly)));
    title(['Polyphase Section ', num2str(k), ' Magnitude Response']);
    xlabel('Normalized Frequency (\times \pi rad/sample)');
    ylabel('Magnitude');
    grid on;
    
    % Phase response
    subplot(2, 1, 2);
    plot(W_poly/pi, unwrap(angle(H_poly)));
    title(['Polyphase Section ', num2str(k), ' Phase Response']);
    xlabel('Normalized Frequency (\times \pi rad/sample)');
    ylabel('Phase (radians)');
    grid on;
end

%% Q3

% Define the inputs
N = 1000;  % Length of the input signal (sufficient for steady-state analysis)
n_samples = 0:N-1;

% Define ω0 values
omega_0 = [pi/50, pi/50 + 2*pi/5, pi/50 + 4*pi/5];
frequencies = {'ω0 = π/50', 'ω0 = π/50 + 2π/5', 'ω0 = π/50 + 4π/5'};

% Loop through each ω0 value
for i = 1:length(omega_0)
    % Generate the input signal
    x_n = cos(omega_0(i) * n_samples);
    
    % Apply the filter
    y_n = filter(b, 1, x_n);

    % Decimation: 5-sample compressor (downsampling by M)
    y_decimated = y_n(1:M:end);
    % Measure the steady-state output
    steady_state_output = y_decimated(ceil(N/(2*M)):end);  % Take half to eliminate transient effects
    % Perform FFT on steady-state output to estimate frequency and amplitude
    Y_fft = fft(steady_state_output);
    [max_val, max_idx] = max(abs(Y_fft));  % Find the peak of the FFT magnitude
    % Output frequency measurement
    output_freq = (max_idx - 1) * (2 * pi / length(steady_state_output));
    % Output peak amplitude measurement
    output_amp = max(abs(steady_state_output));
    
    % Display results
    fprintf('For input %s:\n', frequencies{i});
    fprintf('  Measured Output Frequency: %.4f rad/sample\n', output_freq);
    fprintf('  Measured Peak Amplitude (steady-state): %.4f\n', output_amp);
    
    % Compare with predictions based on filter specifications
    if omega_0(i) <= omega_p
        fprintf('  Prediction: Frequency should pass with amplitude close to input (1 due to filter gain).\n');
    elseif omega_0(i) >= omega_s
        fprintf('  Prediction: Frequency should be highly attenuated due to the stopband.\n');
    else
        fprintf('  Prediction: Transition band behavior may cause attenuation or alteration.\n');
    end
    fprintf('\n');
end

%% Q4

N = 221;  % Filter order

% Frequency response with 1/f stopband decay
% Design a lowpass filter with an ideal passband and a stopband decaying as 1/f

% Frequency vector for design (normalized to Nyquist frequency)
f = linspace(0, 1, 1024);
H = ones(size(f));  % Initialize ideal frequency response
% Passband: Keep magnitude = 1
passband = f <= omega_p/pi;
% Stopband: Decay as 1/f
stopband = f >= omega_s/pi;
H(stopband) = 1 ./ f(stopband);  % Apply 1/f decay in stopband

% Transition band: Apply gradual decay
transition = ~passband & ~stopband;
H(transition) = linspace(1, 1 ./ (omega_s/pi), sum(transition));

% Design FIR filter using inverse FFT
h_1overf = ifftshift(H);  % Impulse response (FIR filter)
h_1overf = h_1overf(1:N+1);  % Truncate to filter order N

% Plot frequency response for the 1/f stopband filter
[H_1overf, W_1overf] = freqz(h_1overf, 1, 1024);

figure;
plot(W_1overf/pi, 20*log10(abs(H_1overf)));
title('1/f Stopband Filter Frequency Response (Magnitude)');
xlabel('Normalized Frequency (\times \pi rad/sample)');
ylabel('Magnitude (dB)');
grid on;

figure;
plot(W_1overf/pi, unwrap(angle(H_1overf)));
title('1/f Stopband Filter Frequency Response (Phase)');
xlabel('Normalized Frequency (\times \pi rad/sample)');
ylabel('Phase (radians)');
grid on;

% Inputs: Same as before
omega_0 = [pi/50, pi/50 + 2*pi/5, pi/50 + 4*pi/5];
frequencies = {'ω0 = π/50', 'ω0 = π/50 + 2π/5', 'ω0 = π/50 + 4π/5'};

% Time domain analysis for each input
for i = 1:length(omega_0)
    % Generate the input signal
    x_n = cos(omega_0(i) * n_samples);
    % Apply the new 1/f stopband filter
    y_n_1overf = filter(h_1overf, 1, x_n);
    % Decimation: 5-sample compressor (downsampling by M)
    y_decimated_1overf = y_n_1overf(1:M:end);
    
    % Measure the steady-state output
    steady_state_output_1overf = y_decimated_1overf(ceil(N/(2*M)):end);  % Take half to eliminate transient effects

    % Perform FFT on steady-state output to estimate frequency and amplitude
    Y_fft_1overf = fft(steady_state_output_1overf);
    [max_val, max_idx] = max(abs(Y_fft_1overf));  % Find the peak of the FFT magnitude
    
    % Output frequency measurement
    output_freq_1overf = (max_idx - 1) * (2 * pi / length(steady_state_output_1overf));
    
    % Output peak amplitude measurement
    output_amp_1overf = max(abs(steady_state_output_1overf));
    
    % Display results
    fprintf('For input %s with 1/f stopband filter:\n', frequencies{i});
    fprintf('  Measured Output Frequency: %.4f rad/sample\n', output_freq_1overf);
    fprintf('  Measured Peak Amplitude (steady-state): %.4f\n', output_amp_1overf);
    
    % Compare with predictions
    if omega_0(i) <= omega_p
        fprintf('  Prediction: Frequency should pass with amplitude close to input.\n');
    elseif omega_0(i) >= omega_s
        fprintf('  Prediction: Frequency should experience less attenuation than with Parks-McClellan.\n');
    else
        fprintf('  Prediction: Transition band behavior may cause noticeable attenuation.\n');
    end
    fprintf('\n');
end



