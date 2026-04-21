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
<img width="1920" height="1073" alt="time_domain_analysis" src="https://github.com/user-attachments/assets/1b5404d5-dc20-49fe-ae6e-8b4628959589" />
<i>Comparison of the corrupted input vs. the recovered signal.</i>

### 2. Spectral Density Analysis
<img width="1920" height="1073" alt="spectral_analysis" src="https://github.com/user-attachments/assets/29b3a23c-8be4-4c82-9119-32935f502b0a" />
<i>Notice the significant attenuation of the 60Hz interference spikes.</i>

## 💻 How to Run
1. Open MATLAB.
2. Ensure the 'DSP System Toolbox' is installed.
3. Run `main_anc.m`.
