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
![Elliptic_Lowpass_Filter__Full_Magnitude_Response](https://github.com/user-attachments/assets/984117e8-0901-46d5-b472-bd626ffd5b87)
![Elliptic_Lowpass_Filter__Phase_Response](https://github.com/user-attachments/assets/e2c51c7c-56d5-4e1b-800b-2a6d4f116bbf)
![Elliptic_Lowpass_Filter__Group_Delay](https://github.com/user-attachments/assets/c8be2220-29a9-45fe-867d-f3c671b9fa36)
![Elliptic_Lowpass_Filter__Passband_Magnitude_Detail](https://github.com/user-attachments/assets/55ebbda6-53be-40d7-82f5-87e6d74eaeb0)
![Elliptic_Lowpass_Filter__Transition_Band_Magnitude_Detail](https://github.com/user-attachments/assets/599b80d3-5fb7-40d6-8d18-196a3879ad4f)
![Elliptic_Lowpass_Filter__Stopband_Magnitude_Detail](https://github.com/user-attachments/assets/076a88ea-08bf-4ef7-b254-2c759f23e44a)






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

![Original_Filter__Magnitude_Response](https://github.com/user-attachments/assets/d6a68451-8fef-400a-8ac7-d49116707309)
![Reconstructed_Filter__Magnitude_Response](https://github.com/user-attachments/assets/354fc10f-b1a1-4b8e-8dc4-dccb0eab15f7)
![Reconstructed_Filter__Phase_Response](https://github.com/user-attachments/assets/cb6f0d4e-c1e3-4be0-bcd2-a98588777b4a)






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
