clear all;
close all;
clc;


%% Highpass Filter Design Using Kaiser Window

% Filter specifications
passbandFreq = 0.6;
stopbandFreq = 0.5;
passbandRipple = 0.01;    % Linear scale (~0.1 dB)
stopbandAttenuation = 40; % in dB

% Design highpass filter using Kaiser window
hpSpec = fdesign.highpass('Fst,Fp,Ast', stopbandFreq, passbandFreq, stopbandAttenuation);
hpFilter = design(hpSpec, 'kaiserwin');
[bHp, aHp] = tf(hpFilter);
[H_hp, w] = freqz(bHp, aHp, 1024);

% Plot magnitude response
figure;
plot(w/pi, 20*log10(abs(H_hp)));
title('Highpass Filter Magnitude Response');
xlabel('Normalized Frequency (×π rad/sample)');
ylabel('Magnitude (dB)');
grid on;
yline(-stopbandAttenuation, 'r--', 'Stopband Spec (-40 dB)');
xline(stopbandFreq, 'r--', '\omega_s = 0.5\pi');
xline(passbandFreq, 'g--', '\omega_p = 0.6\pi');
legend('Magnitude Response', 'Stopband Spec', 'Passband Spec');

% Plot phase response
figure;
plot(w/pi, unwrap(angle(H_hp)));
title('Highpass Filter Phase Response');
xlabel('Normalized Frequency (×π rad/sample)');
ylabel('Phase (radians)');
grid on;

% Zoomed-in plots of magnitude response
figure;
plot(w/pi, 20*log10(abs(H_hp)));
title('Zoomed Magnitude Response (Stopband)');
xlabel('Normalized Frequency (×π rad/sample)');
ylabel('Magnitude (dB)');
xlim([0 0.6]);
ylim([-75 -30]);
grid on;
yline(-stopbandAttenuation, 'r--');
xline(stopbandFreq, 'r--');
xline(passbandFreq, 'g--');

figure;
plot(w/pi, 20*log10(abs(H_hp)));
title('Zoomed Magnitude Response (Passband)');
xlabel('Normalized Frequency (×π rad/sample)');
ylabel('Magnitude (dB)');
xlim([0.55 1]);
ylim([-0.1 0.2]);
grid on;
yline(-stopbandAttenuation, 'r--');
xline(stopbandFreq, 'r--');
xline(passbandFreq, 'g--');

% Plot impulse response
figure;
stem(bHp, 'filled');
title('Highpass Filter Impulse Response');
xlabel('Sample Index');
ylabel('Amplitude');
grid on;

%% FIR Bandpass Filter Sweep using Dolph-Chebyshev Window

% Define parameter vector as [N1 R1 N2 R2 ...]
parameterPairs = [40 30 40 40 50 20 50 30 50 40 60 20 60 30 60 40 70 20 70 25 70 35 80 10 80 15 80 20 80 25 100 10 100 15 100 20];

for idx = 1:2:length(parameterPairs)
order = parameterPairs(idx);
attenuation = parameterPairs(idx+1);
designAndPlotBandpassFIR(order, attenuation);
end

%% Function to Design and Plot FIR Bandpass Filter
function designAndPlotBandpassFIR(filterOrder, sidelobeAttenuation)

% Bandpass filter specs
passbandRipple_dB = 4;
stopbandAttenuation_dB = 40;
wp1 = 0.4;
wp2 = 0.6;
ws1 = 0.3;
ws2 = 0.7;
wn = [wp1 wp2];

% Create Dolph-Chebyshev window
window = chebwin(filterOrder + 1, sidelobeAttenuation);

% Design bandpass FIR filter
b = fir1(filterOrder, wn, window);

% Normalize gain at center frequency
centerFreq = mean(wn);
[H, w] = freqz(b, 1, 2048);
gainAtCenter = abs(interp1(w/pi, H, centerFreq));
b = b / gainAtCenter;
[H, w] = freqz(b, 1, 2048);

% Impulse response
figure;
stem(b);
title('FIR Bandpass Filter Impulse Response');
xlabel('n'); ylabel('h[n]');
grid on;

% Frequency response (full)
figure;
plot(w/pi, 20*log10(abs(H)));
grid on;
title(sprintf('Bandpass FIR Frequency Response (N=%d, R=%d)', filterOrder, sidelobeAttenuation));
xlabel('Normalized Frequency (×π rad/sample)');
ylabel('Magnitude (dB)');
hold on;
yline(-passbandRipple_dB, 'g--', 'Passband Spec');
yline(-stopbandAttenuation_dB, 'r--', 'Stopband Spec');
xline(ws1, 'r--');
xline(wp1, 'g--');
xline(wp2, 'g--');
xline(ws2, 'r--');
legend('Magnitude Response', 'Passband Spec', 'Stopband Spec');
ylim([-120 5]);

% Zoomed frequency response
figure;
plot(w/pi, 20*log10(abs(H)));
grid on;
title(sprintf('Zoomed Frequency Response (N=%d)', filterOrder));
xlabel('Normalized Frequency (×π rad/sample)');
ylabel('Magnitude (dB)');
xlim([0.35 0.65]);
ylim([-2 1]);

% Phase response
figure;
plot(w/pi, unwrap(angle(H)));
title('FIR Bandpass Filter Phase Response');
xlabel('Normalized Frequency (×π rad/sample)');
ylabel('Phase (radians)');
grid on;

end
