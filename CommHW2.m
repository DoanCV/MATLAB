%% Homework 2 MATLAB
% Warning: The final audio output, after the lowpass filter, has an increased pitch

%Preclean
clear;
clc;
close all;

%% Load in audio clip
% The following clip is taken from a world renowned playwright, it is in Spanish 

[m_t, f_s] = audioread('Carl_Smith.mp3');

m_t = m_t(:,1)'; %transpose
max = max(abs(m_t));
m_t = m_t ./ max; %divide each value by max to gurantee max is 1 and the rest are scaled similarly

f_s_0 = f_s;
f_s = f_s*40;
m_t = interp(m_t, 40);  

T = length(m_t)/f_s;
N = f_s*T;
t = linspace(0,T,N); % the clip is about 5 seconds long

figure;
plot(t, m_t);
xlabel('time');
title('Number 1: Original signal');

%The bandwidth is about 5 kHZ

%% Number 1
w_d = linspace(-pi,pi,N);
f = w_d*f_s/(2*pi); %wd = 2*pi*f/fs

M_w = fftshift(fft(m_t)/f_s);

figure;
subplot(2,1,1);
semilogy(f, abs(M_w));
xlabel('Hz');
title('Magnitude of Fourier Transform');

subplot(2,1,2);
plot(f, unwrap(angle(M_w)));
title('Phase of Fourier Transform');
xlabel('Hz');

sgtitle('Number 1');
%% Number 2
% The range is from 535-1605 kHz
f_c = 550000;
c_t = cos(2*pi*f_c*t); 

%% Number 3
dsb_sc = m_t .* c_t;
dsb = (1 + m_t) .* c_t;

DSB_SC = fftshift(fft(dsb_sc)/f_s);
DSB = fftshift(fft(dsb)/f_s);

figure;
subplot(2,2,1);
plot(t, dsb_sc);
xlabel('time');
title('DSB SC in time domain');

subplot(2,2,2);
plot(t, dsb);
xlabel('time');
title('DSB in time domain');

subplot(2,2,3);
semilogy(f, abs(DSB_SC));
xlabel('Hz');
title('DSB SC in frequency domain');

subplot(2,2,4);
semilogy(f, abs(DSB));
xlabel('Hz');
title('DSB in frequency domain');

sgtitle('Number 3');

% The graphs explode, especially the DSB(w) at pilot tone

%% Number 4
H_m_f = hilbertF_trans(m_t, f); %Call to hilbert_trans function which is my hilbert implementation in freq domain
H_m_t = hilbertT_trans((H_m_f)); %Call to hilbert_trans function which is ifft of freq domain version

U_lssb = dsb_sc + H_m_t .* sin(2*pi*f_c*t);
U_ussb = dsb_sc - H_m_t .* sin(2*pi*f_c*t);

U_LSSB = fftshift(fft(U_lssb)/f_s);
U_USSB = fftshift(fft(U_ussb)/f_s);

figure;
subplot(2,2,1);
plot(t, real(U_lssb));
xlim([0 5]);
xlabel('time');
title('U lssb time domain');

subplot(2,2,2);
plot(t, real(U_ussb));
xlim([0 5]);
xlabel('time');
title('U ussb time domain');

subplot(2,2,3);
semilogy(f, abs(U_LSSB));
xlabel('Hz');
title('U LSSB frequency domain');

subplot(2,2,4);
semilogy(f, abs(U_USSB));
xlabel('Hz');
title('U LSSB frequency domain');

sgtitle('Number 4');
%% Number 5
%amplitude: 0 < a < 1
conventional = 1 * (1 + m_t) .* c_t;
CONVENTIONAL = fftshift(fft(conventional/f_s));

figure;
subplot(2,1,1);
plot(t, conventional);
xlabel('time');
title('Conventional AM in time domain');

subplot(2,1,2);
semilogy(f, abs(CONVENTIONAL));
xlabel('Hz');
title('Conventional AM in frequency domain');

sgtitle('Number 5');
%% Number 6
%Rectify, all negatives are 0
conventional(conventional < 0) = 0;

CONVENTIONAL = fftshift(fft(conventional)/f_s);

figure;
subplot(2,1,1);
plot(t, conventional);
xlabel('time');
title('Conventional time domain');

subplot(2,1,2);
semilogy(f, abs(CONVENTIONAL));
xlabel('Hz');
title('Conventional frequency domain');

sgtitle('Number 6 Rectified');

%apply lowpass filter
lowpass = lowpass(conventional, 4000, f_s); %chose cutoff frequency close to bandwidth
LOWPASS = fftshift(fft(lowpass)/f_s);

figure;
subplot(2,1,1);
plot(t, lowpass);
xlabel('time');
title('Lowpass time domain');

subplot(2,1,2);
semilogy(f, abs(LOWPASS));
xlabel('Hz');
title('Lowpass frequency domain');

sgtitle('Number 6 Lowpass');

%Play the audio
lowpass = downsample(lowpass, 40); 
sound(lowpass, f_s_0)