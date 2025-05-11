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
  
