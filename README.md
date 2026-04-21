# Real-Time Adaptive Audio Interference Cancellation (ANC)
Developed using MATLAB & the DSP System Toolbox.

## 🚀 Project Overview
This project implements a digital signal processing pipeline designed to extract voice signals from environments with high electromagnetic interference (EMI). Using a **Least Mean Squares (LMS)** adaptive algorithm, the system identifies and subtracts non-stationary noise (such as 60Hz power-line hum) in real-time.

## 🛠 Technical Features
* **Adaptive Filtering:** 32-tap FIR structure using the LMS update rule.
* **Spectral Analysis:** Power Spectral Density (PSD) estimation and spectrogram visualization to validate noise floor reduction.
* **Performance Metrics:** Achieved a measurable **SNR improvement of ~15 dB**.
* **Stability Control:** Optimized step-size ($\mu$) for convergence without filter divergence.

## 📈 Visualizations
### 1. Time-Domain Recovery
![Time Domain Plot](<img width="1920" height="1073" alt="time_domain_analysis" src="https://github.com/user-attachments/assets/a79d4c80-4e6b-4c98-b4b5-8a7c025ec9b3" />)
*Comparison of the corrupted input vs. the recovered signal.*

### 2. Spectral Density Analysis
![PSD Plot](<img width="1920" height="1073" alt="spectral_analysis" src="https://github.com/user-attachments/assets/26d49892-d008-4676-999c-d1b23b1ff957" />)
*Notice the significant attenuation of the 60Hz interference spikes.*

## 💻 How to Run
1. Open MATLAB.
2. Ensure the 'DSP System Toolbox' is installed.
3. Run `main_anc.m`.
