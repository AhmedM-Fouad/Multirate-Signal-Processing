IIR Filter Design and Analysis with MATLAB

MATLAB Signal Processing Filter Design Academic Project

This project demonstrates comprehensive IIR filter design techniques using MATLAB, focusing on elliptic filters, allpass decomposition, lattice structures, and quantization effects. The implementation is organized into five well-structured sections (Q1-Q5), each exploring different aspects of digital filter design and analysis.
Table of Contents

    Project Overview

    Implementation Details

        Q1: Elliptic Lowpass Filter Design

        Q2: Allpass Decomposition

        Q3: Filter Transformation

        Q4: Lattice Structure

        Q5: Quantization Analysis

    Results

    Requirements

    Usage

    References

🚀 Project Overview

This MATLAB implementation provides a hands-on exploration of:

    Elliptic IIR filter design with precise specification control

    Allpass decomposition techniques for filter realization

    Lattice-ladder structures for robust implementation

    Finite wordlength effects analysis through quantization

    Comprehensive frequency response visualization

The project serves as both an educational resource and practical reference for digital signal processing applications.
🔍 Implementation Details
🔹 Q1: Elliptic Lowpass Filter Design

Designs and analyzes a lowpass elliptic filter with specified parameters.
matlab
Copy

% Filter Specifications
Wp = 0.45;  % Normalized passband edge frequency (0.45π rad/sample)
Ws = 0.55;  % Normalized stopband edge frequency (0.55π rad/sample)
Rp = 0.1;   % Passband ripple (0.1 dB)
Rs = 30;    % Stopband attenuation (30 dB)

% Filter Design
[N, Wn] = ellipord(Wp, Ws, Rp, Rs);  % Determine minimum order
[b, a] = ellip(N, Rp, Rs, Wn);       % Design elliptic filter

% Frequency Response Analysis
[h, w] = freqz(b, a);                % Frequency response
grp_delay = grpdelay(b, a, 1024);    % Group delay calculation

Key Features:

    Precise control over frequency edges and ripple parameters

    Automatic determination of minimum filter order

    Comprehensive frequency domain analysis

    Visualization of magnitude, phase, and group delay

🔹 Q2: Allpass Decomposition

Decomposes the elliptic filter into allpass sections and reconstructs it.
matlab
Copy

% Allpass Decomposition
[d1, d2] = tf2ca(b, a);  % Convert to coupled allpass form

% Filter Reconstruction
num = 0.5*(flip(d1)*d2 + flip(d2)*d1);  % Numerator reconstruction
den = d1*d2;                            % Denominator reconstruction

% Validation
reconstruction_error = max([max(abs(num-b)), max(abs(den-a))]);
disp(['Maximum reconstruction error: ' num2str(reconstruction_error)]);

Key Features:

    Conversion between direct-form and allpass implementations

    Mathematical reconstruction verification

    Separate analysis of allpass components

    Phase response comparison

🔹 Q3: Filter Transformation

Derives complementary highpass filter from allpass sections.
matlab
Copy

% Highpass Filter Creation
num_hp = 0.5*(flip(d1)*d2 - flip(d2)*d1);  % Highpass numerator
den_hp = d1*d2;                            % Denominator (same as lowpass)

% Frequency Response Comparison
[h_lp, w] = freqz(b, a);
[h_hp, w] = freqz(num_hp, den_hp);

Key Features:

    Generation of complementary filter pair

    Magnitude and phase comparison

    Demonstration of allpass transformation properties

    Power complementary relationship verification

🔹 Q4: Lattice Structure

Converts allpass sections to lattice-ladder realization.
matlab
Copy

% Lattice Conversion
[k1, v1] = tf2latc(1, d1);  % First allpass section
[k2, v2] = tf2latc(1, d2);  % Second allpass section

% Display Lattice Parameters
disp('First allpass section lattice parameters:');
disp('Reflection coefficients (k1):'); disp(k1);
disp('Ladder coefficients (v1):'); disp(v1);

Key Features:

    Robust lattice structure implementation

    Parameter extraction and display

    Comparison with direct-form implementation

    Numerical properties analysis

🔹 Q5: Quantization Analysis

Investigates finite wordlength effects on filter performance.
matlab
Copy

% Quantization Functions
function xq = quantize(x, nbits)
    xq = fi(x, 1, nbits, nbits-1);  % Signed fixed-point quantization
    xq = double(xq);
end

% Quantization Effects
b_16bit = quantize(b, 16);  % 16-bit coefficients
a_16bit = quantize(a, 16);

% Lattice Quantization
k1_10bit = quantize(k1, 10);  % 10-bit lattice coefficients

Key Features:

    Custom quantization function

    16-bit and 10-bit precision comparison

    Direct-form vs lattice structure robustness

    Frequency response degradation analysis
