# IIR Filter Design and Analysis using Elliptic Filters in MATLAB

This repository contains MATLAB code to design, analyze, and implement an **elliptic lowpass IIR filter** using various techniques including **allpass decomposition**, **highpass transformation**, **lattice structure conversion**, and **quantized coefficient analysis**.

## Contents

- [Q1](#q1-design-and-analyze-an-elliptic-lowpass-filter): Design and analyze an elliptic lowpass filter  
- [Q2](#q2-allpass-decomposition-and-reconstruction): Allpass decomposition and reconstruction  
- [Q3](#q3-lowpass-and-highpass-filter-via-allpass-transformation): Generate highpass filter via allpass transformation  
- [Q4](#q4-convert-allpass-sections-to-lattice-structure): Convert allpass sections to lattice form  
- [Q5](#q5-coefficient-quantization-effects): Study the impact of coefficient quantization  

---

## Q1: Design and Analyze an Elliptic Lowpass Filter

**Specifications:**
- Passband edge: `Wp = 0.45`
- Stopband edge: `Ws = 0.55`
- Passband ripple: `Rp = 0.1 dB`
- Stopband attenuation: `Rs = 30 dB`

**Key Steps:**
- Compute minimum filter order with `ellipord`
- Design elliptic filter with `ellip`
- Analyze magnitude, phase, and group delay using `freqz` and `grpdelay`

---

## Q2: Allpass Decomposition and Reconstruction

**Key Steps:**
- Decompose the elliptic filter into two allpass filters using `tf2ca`
- Reconstruct the filter using symmetric combination of the two allpass sections:
  ```matlab
  num = 0.5 * (flip(d1) * d2 + flip(d2) * d1);
  den = d1 * d2;
  ```
- Compare with the original filter using `freqz`
- Plot magnitude and phase responses
- Visualize the allpass components separately

---

## Q3: Lowpass and Highpass Filter via Allpass Transformation

**Key Steps:**
- Use the allpass sections from Q2
- Construct the complementary highpass filter using:
  ```matlab
  num3 = 0.5 * (flip(d1) * d2 - flip(d2) * d1);
  ```
- Analyze the highpass filter's frequency response
- Compare it with the original lowpass filter
- Display both magnitude and phase responses

---

## Q4: Convert Allpass Sections to Lattice Structure

**Key Steps:**
- Use `tf2latc` to convert each allpass section to lattice form
- Extract:
  - Reflection coefficients `k`
  - Ladder coefficients `v`
- Display the lattice coefficients for both allpass filters

---

## Q5: Coefficient Quantization Effects

**Key Steps:**
- Quantize filter coefficients to finite precision:
  - 16-bit and 10-bit fixed-point for both direct form and lattice form
- Reconstruct the filters from quantized coefficients:
  - Use `latc2tf` to recover numerator/denominator from lattice form
- Analyze performance degradation using `freqz`
- Compare:
  - Original filter
  - 16-bit and 10-bit quantized versions (both direct and lattice forms)
