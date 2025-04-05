# Multirate-Signal-Processing
Bandpass Elliptic Filter Design
Ahmed Fouad
August 8, 2024
Analysis of MATLAB Bandpass Elliptic Filter
Code
1. Filter Specifications
• Normalized frequency bands (normalized to Nyquist frequency = 1):
– Passband: 0.3 to 0.7
– Stopbands: below 0.2 and above 0.8
• Gain requirements:
– Passband ripple (Gp): 0.99 (min allowed passband gain)
– Stopband attenuation (Gs): 0.01 (max allowed stopband gain)
• Converted to dB scale:
Rp = −20 log10(Gp) ≈ 0.0873 dB
Rs = −20 log10(Gs) = 40 dB
2. Filter Design
• ellipord() calculates the minimum filter order N and natural frequency
Wn
• ellip() designs the elliptic filter with:
– Order N
– Passband ripple Rp
– Stopband attenuation Rs
– Bandpass type with cutoff frequencies Wn
1
3. Filter Implementation
• Transfer function ([a, b] coefficients) converted to Second-Order Sec-
tions (SOS) using tf2sos()
– SOS form is numerically more stable for higher-order filters
– Includes a gain factor g
4. Analysis and Visualization
• fvtool() shows the frequency response (magnitude)
• grpdelay() plots the group delay (phase linearity)
• Commented alternative approach uses pole-zero-gain design first
5. Coefficient Output
• Displays SOS coefficients (for implementation)
• Shows original numerator (a) and denominator (b) coefficients
Key Characteristics of Elliptic Filters
1. Equiripple behavior: Ripples in both passband and stopband
2. Sharp transition: Fastest transition for given order
3. Nonlinear phase: As seen in group delay plot
4. High selectivity: Good for sharp cutoff requirements
Potential Applications
• When strict frequency-domain specs are needed
• Where filter order must be minimized
• Applications tolerant of nonlinear phase response
Note on Normalized Frequencies
• 1.0 = Nyquist frequency ( 1
2 sampling rate)
• Example: For 10 kHz sample rate:
– Passband = 1.5–3.5 kHz
