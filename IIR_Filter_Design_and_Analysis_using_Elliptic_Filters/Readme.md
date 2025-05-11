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

![Elliptic_Lowpass_Filter__Full_Magnitude_Response](https://github.com/user-attachments/assets/eb3a31a3-7ab9-44a6-a4e6-397e344cd2b6)
![Elliptic_Lowpass_Filter__Phase_Response](https://github.com/user-attachments/assets/4f53f68b-8dc1-4d79-957f-767418f85dbf)
![Elliptic_Lowpass_Filter__Group_Delay](https://github.com/user-attachments/assets/d24fda8a-a0ad-4983-8485-e4daf5f36767)
![Elliptic_Lowpass_Filter__Passband_Magnitude_Detail](https://github.com/user-attachments/assets/2b9d9fab-942d-47a0-9877-aabbdb9b3dfb)
![Elliptic_Lowpass_Filter__Transition_Band_Magnitude_Detail](https://github.com/user-attachments/assets/4447d608-b768-4ba1-8a38-4d53fc38de20)

## Q2: Convert to and Analyze a Structure Using Two Allpass Filters

- Uses `tf2ca`, which decomposes the transfer function into two allpass filters (`d1` and `d2`)
- Reconstructs the original filter from allpass sections:
  
H(z) = ½[A₁(z⁻¹)A₂(z) + A₂(z⁻¹)A₁(z)]


- `MaxDiff` compares the original coefficients with the reconstructed ones
- Multiple plots compare the magnitude and phase responses of the reconstructed filter with the original


![Original_Filter__Magnitude_Response](https://github.com/user-attachments/assets/41a0200f-6131-42cd-a7e0-c4ea7b920a3b)
![Reconstructed_Filter__Magnitude_Response](https://github.com/user-attachments/assets/a3993d41-ba37-4ccb-a979-50f61da6fa09)
![Reconstructed_Filter__Phase_Response](https://github.com/user-attachments/assets/48015428-9409-4cb9-9817-8b0436615b98)
![Reconstructed_Filter__Group_Delay](https://github.com/user-attachments/assets/69eb5c1f-ceb4-4de5-8ef4-1fe41f989365)
![Denominator_Filter__Magnitude_Response](https://github.com/user-attachments/assets/76841848-b797-42b3-8ec0-a8d3a9d8916d)
![Denominator_Filter__Phase_Response](https://github.com/user-attachments/assets/7f5a91ba-9773-48ae-97ba-041495e5202e)



## Q3: Compare Lowpass and Highpass Filters

- Uses the same lowpass design, but also forms a highpass filter from the allpass decomposition:

H_HP(z) = ½[A₁(z⁻¹)A₂(z) - A₂(z⁻¹)A₁(z)]


- Plots show magnitude and phase responses for both filters on the same axes for comparison

![Power_Complementary_Filter__Magnitude_Response](https://github.com/user-attachments/assets/741f88b4-fcea-4ba7-9f19-a6896371e954)
![Power_Complementary_Filter__Phase_Response](https://github.com/user-attachments/assets/481e9663-b8d4-4455-a5ae-4db418b45c52)
![Lowpass_and_Highpass_Power_Complementary_Filters](https://github.com/user-attachments/assets/1496f774-c3e2-480f-b0d1-8bf8d4ee7387)

## Q4: Convert Allpass Filters to Lattice Form

- Converts the allpass filter sections (`d1`, `d2`) to lattice filter coefficients using `tf2latc`
- Displays reflection coefficients `k` and `v`, useful for fixed-point and efficient implementations

## Q5: Quantization Effects on Filter Performance

**Direct Form Quantization:**

- 16-bit: `quantize(b, 15)`
- 10-bit: `quantize(b, 9)`

**Lattice Form Quantization:**

- Lattice coefficients `k`, `v` are quantized and converted back using `latc2tf`
![Quantization_Effects_Comparison_16bit](https://github.com/user-attachments/assets/606d288d-d1bc-46a6-a431-88d37872b908)
![Quantization_Effects_Comparison_10bit](https://github.com/user-attachments/assets/e4580336-d387-4d98-bb0b-a217692c9e60)


**Comparison Plots:**

- Compares original vs. quantized (both direct and lattice forms) filter responses
- Focuses on attenuation in the stopband between 0.5 and 0.65 (normalized frequency)
- Demonstrates quantization effects and robustness of lattice structure
