
## 🟦 Q1: FIR Lowpass Filter Design with Parks–McClellan

### 🎯 Goal:
Design a lowpass filter using the **Parks–McClellan (Remez) algorithm**, and visualize its impulse and frequency responses.

### 📌 Steps:

1. **Define specs:**
   ```matlab
   wp = 0.6*pi;   % passband edge (rad/sample)
   ws = 0.5*pi;   % stopband edge
   Rp = 1;        % passband ripple in dB
   Rs = 40;       % stopband attenuation in dB
   ```

2. **Normalize and calculate parameters:**
   ```matlab
   [N, fo, ao, w] = firpmord([fs fp], [0 1], [10^(-Rs/20), (10^(Rp/20)-1)/(10^(Rp/20)+1)]);
   ```

   This estimates the minimum order `N` and the frequency/weight vectors for `firpm`.

3. **Design filter using Parks–McClellan:**
   ```matlab
   b = firpm(N, fo, ao, w);
   ```

4. **Plot:**
   - Impulse response using `stem`.
   - Frequency response using `freqz`.

5. **Add specification lines:**
   - Use `xline` and `yline` to annotate passband and stopband constraints.

---

## 🟦 Q2: Eigenfilter Design and Comparison

This section introduces a custom FIR filter design using **eigenvalue decomposition**, with a tunable weighting factor `alpha`.

### 🔁 Two Filters Are Designed:
```matlab
b1 = eigen_filterII(alpha1);   % alpha1 = 0.2
b2 = eigen_filterII(alpha2);   % alpha2 = 0.5
```

### 📊 Comparison With:
A least-squares designed FIR filter:
```matlab
h_firls = firls(N-1, [0, 0.3, 0.5, 1], [1, 1, 0, 0]);
```

### 📈 Plots:
- Magnitude responses of all three filters.
- Impulse responses (using `stem`) to observe time-domain performance.

---

## 🔧 Function: `eigen_filter(alpha)`

Designs a **Type I FIR lowpass eigenfilter**.

### 🔑 Key Concepts:

1. **Passband and Stopband Frequencies**:
   ```matlab
   wp = 0.3*pi;
   ws = 0.5*pi;
   N = 30;  % Filter order
   ```

2. **Matrix Construction**:
   - `Ps`: Stopband energy matrix
   - `Pp`: Passband energy matrix
   - Combined matrix:
     ```matlab
     P = alpha * Ps + (1 - alpha) * Pp;
     ```

3. **Eigenvector Computation**:
   - Select eigenvector corresponding to smallest eigenvalue.
   - Construct symmetric impulse response (Type I FIR).

4. **Normalization**:
   - Scale coefficients to ensure unity gain (DC normalization).

5. **Plot Outputs**:
   - Impulse response (`stem`)
   - Frequency response (`freqz`)
   - Specification lines with `xline`, `yline` to mark ωₛ and ωₚ.
