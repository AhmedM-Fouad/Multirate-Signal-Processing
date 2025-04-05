# Multirate-Signal-Processing
\documentclass{article}
\usepackage{amsmath}
\usepackage{listings}

\title{Bandpass Elliptic Filter Design}
\author{Ahmed Fouad}
\date{August 8, 2024}

\begin{document}

\maketitle

\section*{Analysis of MATLAB Bandpass Elliptic Filter Code}

\subsection*{1. Filter Specifications}
\begin{itemize}
    \item \textbf{Normalized frequency bands} (normalized to Nyquist frequency = 1):
    \begin{itemize}
        \item Passband: $0.3$ to $0.7$
        \item Stopbands: below $0.2$ and above $0.8$
    \end{itemize}
    
    \item \textbf{Gain requirements}:
    \begin{itemize}
        \item Passband ripple ($G_p$): $0.99$ (min allowed passband gain)
        \item Stopband attenuation ($G_s$): $0.01$ (max allowed stopband gain)
    \end{itemize}
    
    \item Converted to dB scale:
    \begin{align*}
        R_p &= -20 \log_{10}(G_p) \approx 0.0873 \text{ dB} \\
        R_s &= -20 \log_{10}(G_s) = 40 \text{ dB}
    \end{align*}
\end{itemize}

\subsection*{2. Filter Design}
\begin{itemize}
    \item \texttt{ellipord()} calculates the minimum filter order $N$ and natural frequency $W_n$
    \item \texttt{ellip()} designs the elliptic filter with:
    \begin{itemize}
        \item Order $N$
        \item Passband ripple $R_p$
        \item Stopband attenuation $R_s$
        \item Bandpass type with cutoff frequencies $W_n$
    \end{itemize}
\end{itemize}

\subsection*{3. Filter Implementation}
\begin{itemize}
    \item Transfer function (\texttt{[a, b]} coefficients) converted to Second-Order Sections (SOS) using \texttt{tf2sos()}
    \begin{itemize}
        \item SOS form is numerically more stable for higher-order filters
        \item Includes a gain factor $g$
    \end{itemize}
\end{itemize}

\subsection*{4. Analysis and Visualization}
\begin{itemize}
    \item \texttt{fvtool()} shows the frequency response (magnitude)
    \item \texttt{grpdelay()} plots the group delay (phase linearity)
    \item Commented alternative approach uses pole-zero-gain design first
\end{itemize}

\subsection*{5. Coefficient Output}
\begin{itemize}
    \item Displays SOS coefficients (for implementation)
    \item Shows original numerator (\texttt{a}) and denominator (\texttt{b}) coefficients
\end{itemize}

\subsection*{Key Characteristics of Elliptic Filters}
\begin{enumerate}
    \item \textbf{Equiripple behavior}: Ripples in both passband and stopband
    \item \textbf{Sharp transition}: Fastest transition for given order
    \item \textbf{Nonlinear phase}: As seen in group delay plot
    \item \textbf{High selectivity}: Good for sharp cutoff requirements
\end{enumerate}

\subsection*{Potential Applications}
\begin{itemize}
    \item When strict frequency-domain specs are needed
    \item Where filter order must be minimized
    \item Applications tolerant of nonlinear phase response
\end{itemize}

\subsection*{Note on Normalized Frequencies}
\begin{itemize}
    \item $1.0 =$ Nyquist frequency ($\frac{1}{2}$ sampling rate)
    \item Example: For 10 kHz sample rate:
    \begin{itemize}
        \item Passband = $1.5$--$3.5$ kHz
    \end{itemize}
\end{itemize}

\end{document}
