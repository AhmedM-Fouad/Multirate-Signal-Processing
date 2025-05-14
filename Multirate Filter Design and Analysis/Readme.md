
# Multirate Filter Design and Analysis

This MATLAB script explores multirate filtering using a decimation factor `M = 5`. It covers:

- FIR design via Parks–McClellan
- Polyphase decomposition
- Time-domain analysis
- A custom filter with 1/f stopband decay

---

## Q1: FIR Design with Parks–McClellan Algorithm

### Specs
- Decimation factor: `M = 5`
- Transition width: `\delta\omega = \pi/100`
- Passband edge: `\omega_p = \pi/M - \delta\omega`
- Stopband edge: `\omega_s = \pi/M + \delta\omega`
- Ripple: `Rp = 1 dB`, Attenuation: `Rs = 30 dB`

### Design
- Normalized frequencies: `f_p = \omega_p/\pi`, `f_s = \omega_s/\pi`
- Order: `n = 221`
- Design via `firpm`

### Analysis
- Impulse response plotted via `stem`
- Full and zoomed frequency response with specification overlays

---

## Q2: Polyphase Decomposition

- Type-I polyphase decomposition of FIR filter for decimation factor `M`
- `b(k:M:end)` extracts each polyphase component
- For each subfilter:
  - Plot magnitude and phase response using `freqz`

---

## Q3: Time-Domain Testing with Decimation

### Inputs:
- Three cosine signals:
  - `\omega_0 = \pi/50`
  - `\omega_0 + 2\pi/5`
  - `\omega_0 + 4\pi/5`

### Procedure:
- Filter each input
- Downsample by `M`
- Measure steady-state output:
  - FFT to get output frequency and amplitude
- Compare with design predictions:
  - Passband: expect unity gain
  - Stopband: expect attenuation
  - Transition: unpredictable behavior

---

## Q4: Custom Filter with 1/f Stopband Decay

### Design
- Construct desired frequency response `H(f)`:
  - Passband: `H(f) = 1`
  - Stopband: `H(f) = 1/f`
  - Transition: linear decay between passband and stopband edges
- Apply inverse FFT and truncate to filter order `N = 221`

### Analysis
- Plot magnitude and phase response
- Same cosine inputs tested with new filter
- Downsampled outputs analyzed via FFT

### Observations
- `1/f` filter yields smoother roll-off
- Stopband signals not as attenuated as Parks–McClellan
- Useful when less sharp transitions are acceptable

---

This script provides a practical demonstration of multirate filter behavior across various input frequencies and design methods.

