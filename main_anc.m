% Real-Time Adaptive Audio Interference Cancellation
% Author: Aadarsh Tobby Kakkathottil
% University: UMass Amherst
% Description: Implementation of an LMS Adaptive Filter to remove 
% 60Hz hum and stochastic noise from an audio signal.

clear; clc;

% --- STAGE 1: SETUP ---
load handel.mat; %loads a short excerpt from Handel's Hallelujah chorus
% y is the vector for audio signal data, 
% Fs is the sampling frequency of the audio
% Fs is 8192 ie a sampling frequency of 8192 Hz

clean_signal = y(1:Fs*3); % samples Fs*3 times taking 3 seconds worth of samples
t = (0:length(clean_signal)-1)'/Fs; %time begins from zero to Fs*3/Fs which is 3

% Create a 60Hz sine wave "Hum" + some random White Noise
hum = 0.5 * sin(2*pi*60*t); %amplitude of 0.5, frequency of 60 Hz for 3 seconds
noise = 0.1 * randn(size(clean_signal)); 
%scales down random noise to 0.1x, to ensure
%magnitude is much smaller than hum's magnitude, and we ensure it has the
%same size as the clean signal array to add noise throughout the audio
interference = hum + noise; 
%external interference to the audio is the hum and the noise combined

% The signal the microphone actually "hears"
corrupted_signal = clean_signal + interference;

% Visualize the corruption
figure(1);
subplot(2,1,1); plot(t, clean_signal); title('Clean Audio'); grid on;
subplot(2,1,2); plot(t, corrupted_signal); title('Corrupted Audio (60Hz Hum + Noise)'); grid on;

% --- STAGE 2: ADAPTIVE FILTERING ---
% We assume we have a "reference" of the noise (like a secondary mic)
ref_noise = interference + 0.05*randn(size(interference)); %more random noise

% Initialize LMS Parameters
filterOrder = 32; % Number of coefficients (Taps)
mu = 0.01;        % Step size (Convergence rate)
lms = dsp.LMSFilter('Length', filterOrder, 'StepSize', mu);

% Run the filter
% 'y_est' is what the filter thinks the noise looks like
% 'clean_est' removes the estimated noise from the corrupted signal
[y_est, clean_est] = lms(ref_noise, corrupted_signal);

%LMS Filter takes the reference noise as input and this is what the filter
%tries to replicate, shaping its 32 taps to produce an estimate of the
%noise as y_est which can be subtracted from the corrupted signal to
%produce a clean output

%it can be thought of as corrupted signal = clean signal + interference
%and the reference noise = interference + small noise, 
%so the only correlation between the two inputs is the interference which
%it maps to the best of its ability in y_est and then subtracts from the
%corrupted signal to produce clean_est

%The corrupted signal is the target the LMS filter is trying to match, so
%it tries to minimize the difference between the 

% Compare the results
figure(2);
subplot(3,1,1); plot(t, corrupted_signal); title('Input to System'); grid on;
subplot(3,1,2); plot(t, clean_est); title('Recovered Signal via LMS Adaptive Filter'); grid on;
subplot(3,1,3); plot(t, y_est); title('Recovered 60 Hz Interference'); grid on;

% --- STAGE 3: VALIDATION ---
% Calculate SNR Improvement
snr_before = snr(clean_signal, interference); 
%SNR with clean signal and noisy interference before (expect higher number)
snr_after = snr(clean_signal, clean_est - clean_signal);
%SNR with the clean signal and left over noise
%which is the difference between the clean LMS estimate and the signal

fprintf('SNR Improvement: %.2f dB\n', snr_after - snr_before);

% Frequency Domain Visualization (The "Resume" Plot)
figure(3);
%visualizing the corrupted signal and the clean signal
%in the frequency domain, using a rectangular bin to 
%separate frequencies into 0.33 Hz per bin
[pxx_corr, f] = periodogram(corrupted_signal, rectwin(length(corrupted_signal)), length(corrupted_signal), Fs);
[pxx_clean, ~] = periodogram(clean_est, rectwin(length(clean_est)), length(clean_est), Fs);

%we convert power in decibels by doing 10log10(power)
plot(f, 10*log10(pxx_corr), 'r', f, 10*log10(pxx_clean), 'b');
xlim([0 200]);
xlabel('Frequency (Hz)'); ylabel('Magnitude (dB/Hz)');
legend('Corrupted', 'Cleaned');
title('Spectral Density Analysis');
grid on;