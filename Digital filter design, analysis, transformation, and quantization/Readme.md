# Filter Design and Analysis

## Q1: Design and Analyze an Elliptic Lowpass Filter

**Design Specs:**

- Passband edge: 0.45 (normalized freq)
- Stopband edge: 0.55
- Passband ripple: 0.1 dB
- Stopband attenuation: 30 dB

**Design Method:**  
`ellipord` and `ellip` compute the filter order and coefficients.

**Analysis:**

- `freqz`: frequency response (magnitude & phase)
- `grpdelay`: group delay
- Several zoomed-in plots are generated to closely inspect different regions of the filter's magnitude response

## Q2: Convert to and Analyze a Structure Using Two Allpass Filters

- Uses `tf2ca`, which decomposes the transfer function into two allpass filters (`d1` and `d2`)
- Reconstructs the original filter from allpass sections:
  

H(z) = ½[A₁(z⁻¹)A₂(z) + A₂(z⁻¹)A₁(z)]


- `MaxDiff` compares the original coefficients with the reconstructed ones
- Multiple plots compare the magnitude and phase responses of the reconstructed filter with the original

## Q3: Compare Lowpass and Highpass Filters

- Uses the same lowpass design, but also forms a highpass filter from the allpass decomposition:

H_HP(z) = ½[A₁(z⁻¹)A₂(z) - A₂(z⁻¹)A₁(z)]


- Plots show magnitude and phase responses for both filters on the same axes for comparison

## Q4: Convert Allpass Filters to Lattice Form

- Converts the allpass filter sections (`d1`, `d2`) to lattice filter coefficients using `tf2latc`
- Displays reflection coefficients `k` and `v`, useful for fixed-point and efficient implementations

## Q5: Quantization Effects on Filter Performance

**Direct Form Quantization:**

- 16-bit: `quantize(b, 15)`
- 10-bit: `quantize(b, 9)`

**Lattice Form Quantization:**

- Lattice coefficients `k`, `v` are quantized and converted back using `latc2tf`

**Comparison Plots:**

- Compares original vs. quantized (both direct and lattice forms) filter responses
- Focuses on attenuation in the stopband between 0.5 and 0.65 (normalized frequency)
- Demonstrates quantization effects and robustness of lattice structure
