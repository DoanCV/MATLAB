%Preclean
clear;
clc;
close all;

%% Number 1
[m, fs] = audioread("Carl_Smith_short.mp3");
m = m(:,1)'; %transpose
max = max(abs(m));

N = length(m);
w_d = linspace(-pi,pi,N);
N2 = 40*N;
w_d2 = linspace(-pi,pi,N2);
fs2 = 40*fs;
f = w_d*fs/(2*pi); %wd = 2*pi*f/fs
f2 = w_d2*fs2/(2*pi);
T = N/fs;
t = linspace(0,T,N);
upt = linspace(0,T,N2);

f_cutoff = fs/2;
Ac = 1;
wc = 600000;
%c_t = cos(wc*t); 

figure;
plot(t, m);
title("Orignal Signal");
xlabel("time");

%% SSB 
[U_ussb, upt] = SSB_AM_Modulate(m,max,Ac,fs,wc);

figure;
plot(upt, real(U_ussb));
title("Upper SSB mod time domain");
xlabel("t");

U_USSB = fftshift(fft(U_ussb)/fs2);

figure;
semilogy(f2, abs(U_USSB));
title("Upper SSB mod freq domain");
xlabel("f");

[demodSSB] = SSB_AM_Demodulate(U_ussb, f_cutoff, wc, upt, fs2);

%soundsc(real(demodSSB), fs);

figure;
subplot(2,1,1);
plot(t, demodSSB);
title("Upper SSB Demod in time domain");
xlabel("t");

demodSSB_freq = fftshift(fft(demodSSB)/fs2);

subplot(2,1,2);
semilogy(f, abs(demodSSB_freq));
title("Upper SSB Demod in freq domain");
xlabel("f");

%% Conventional
[AMmod] = conv_AM_modulate(m,max,1/7,fs,wc);

figure;
subplot(2,1,1);
plot(upt, AMmod);
title("Conventional modulation in time domain");
xlabel("t");

subplot(2,1,2);
semilogy(f2, abs(fftshift(fft(AMmod)/fs2)));
title("Conventional modulation in freq domain");
xlabel("f");

[AMdemod] = conv_AM_demodulate(AMmod,fs2,4000);

%soundsc(real(AMdemod), fs);

figure;
subplot(2,1,1);
plot(t, AMdemod);
title("Conventional demodulation in time domain");
xlabel("t");

subplot(2,1,2);
semilogy(f, abs(fftshift(fft(AMdemod)/fs2)));
title("Conventional demodulation in freq domain");
xlabel("f");

%% PM
[pmMod] = pm_Modulate(m, fs, max, f_cutoff,2);

figure;
subplot(2,1,1);
plot(upt, pmMod);
title("PM Modulated in time domain");
xlabel("t");

pmMod_freq = fftshift(fft(pmMod)/fs2);

subplot(2,1,2);
semilogy(f2, abs(pmMod_freq));
title("PM Modulated in freq domain");
xlabel("f");

[pmDemod] = pm_Demodulate(1, pmMod, f_cutoff, wc, upt, fs2, 2);

%soundsc(pmDemod, fs);

figure;
subplot(2,1,1);
plot(t, pmDemod);
title("PM Demodulated in time domain");
xlabel("t");

subplot(2,1,2);
semilogy(f, abs(fftshift(fft(pmDemod)/fs2)));
title("PM Demodulated in freq domain");
xlabel("f");
%% FM
[fmMod] = fm_modulate(m,1/1.40,wc,fs,max,100000);

figure;
subplot(2,1,1);
plot(upt,fmMod);
title("FM Modulated in time domain");
xlabel("t");

subplot(2,1,2);
semilogy(f2, abs(fftshift(fft(fmMod)/fs2)));
title("FM Modulated in freq domain");
xlabel("f");

w = f2 / (2*pi);
[fmDemod] = fm_demodulate(fmMod/wc,fs,f_cutoff-1000,w);

%soundsc(fmDemod/wc, fs);

figure;
subplot(2,1,1);
plot(t,fmDemod);
title("FM Demodulated in time domain");
xlabel("t");

subplot(2,1,2);
semilogy(f, abs(fftshift(fft(fmDemod)/fs2)));
title("FM Demodulated in freq domain");
xlabel("f");
%% Power 

outputPower = rms(m)^2;
inputPower_SSB = rms(demodSSB)^2;
inputPower_Conv = rms(AMdemod)^2;
inputPower_PM = rms(pmDemod)^2;
inputPower_FM = rms(fmDemod)^2;
disp("Power for Original Signal: " + outputPower);
disp("Power for SSB: " + inputPower_SSB);
disp("Power for Conventional AM: " + inputPower_Conv);
disp("Power for PM: " + inputPower_PM);
disp("Power for FM: " + inputPower_FM);
