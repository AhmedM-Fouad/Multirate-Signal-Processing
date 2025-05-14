# FIR Filter Design and Analysis

This document explains two major sections of MATLAB code:

1. Highpass filter design using Kaiser window
2. Bandpass FIR filter design using the Dolph-Chebyshev window

## Section 1: Highpass Filter using Kaiser Window

**Filter Specs:**

- Passband Frequency (Fp): 0.6 (normalized)
- Stopband Frequency (Fst): 0.5 (normalized)
- Passband Ripple (Rp): 0.01 (linear scale, ~0.1 dB)
- Stopband Attenuation (Rs): 40 dB

**Procedure:**

**Filter design:**
- `fdesign.highpass` is used to define filter specifications
- `design(..., 'kaiserwin')` creates the filter using Kaiser window method

**Analysis:**
- Frequency response is computed using `freqz`
- Plots are generated for:
  - Magnitude response
  - Phase response (with unwrapped phase)
  - Zoomed-in views for passband/stopband specs
  - Impulse response (stem plot)

**Visual Markers:**
- Red dashed line: Stopband specification at -40 dB
- Green dashed line: Passband edge at [your value]
- Legends and grid included for clarity

## Section 2: FIR Bandpass Filter using Dolph-Chebyshev Window

**Function:** `HW4Q2Test3(N, R)`
- `N`: Filter order
- `R`: Sidelobe attenuation (dB)

**Specifications:**
- Passband: [0.4, 0.6]
- Stopband: <0.3, >0.7
- Passband ripple: 4 dB
- Stopband attenuation: 40 dB

**Design Steps:**

1. **Window generation:**
   - `chebwin(N+1, R)` generates Dolph-Chebyshev window

2. **FIR design:**
   - `fir1(N, wn, win)` designs bandpass filter

3. **Normalization:**
   - Gain normalized at the center frequency of the passband

**Analysis:**
- Impulse response (stem plot)
- Frequency magnitude response with passband and stopband specs
- Zoomed-in magnitude and phase responses

**Sweep Test:**
- A vector `param_vec` is defined with alternating N and R values
- A loop runs `HW4Q2Test3(N, R)` for each pair
- This tests various filter orders and sidelobe attenuations, generating plots for each configuration
