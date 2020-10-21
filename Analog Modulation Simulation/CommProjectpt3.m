%Preclean
clear;
clc;
close all;

%Read audio
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

m_scale = m./max;
m_upscale = interp1(t, m_scale, upt);
%% Noise variance

variance = [0.05, .25, 1];
modulation_factor = [.5, 1, 2];

%% Conventional

for i = 1:3
    [convMod] = conv_AM_modulate(m, max * (1 / modulation_factor(i)), Ac, fs, wc-1000); 
    CONVMod = fftshift(fft(convMod)/fs2);
    [demodconv_noiseless] = conv_AM_demodulate(convMod, f_cutoff, fs2);
    
    noise = sqrt(variance(1)) * randn(1,length(m_upscale));

    convNoise = convMod + noise;
    CONVNoise = fftshift(fft(convNoise)/fs2);
    
    [convDemod] = conv_AM_demodulate(convNoise,f_cutoff-1000,fs2);
    
    convDemod = lowpass(convDemod, 2*pi*3000, fs2);
    CONVDemod = fftshift(fft(convDemod)/fs2);
    
    noiseless = (rms(demodconv_noiseless) .^ 2);
    noisy = (rms(convDemod - demodconv_noiseless) .^ 2);
    
    snr_conv = (Ac.^2 * noiseless)/(variance(i)*20000);    
    snr_conv = 10 * log10(snr_conv);
    disp("SNR theoretical for conventional (factor = " + modulation_factor(i) + "): " + snr_conv);
    
    snrconv = 10 * log10(noiseless/noisy);
    disp("SNR for conventional with modulation factor " + modulation_factor(i) + ": " + snrconv);
    
    figure('position', [0, 0, 750, 750]);
    subplot(2,2,1);
    semilogy(f2, abs(fftshift(fft(m_upscale)/fs2)));
    title("Orignal Signal");
    
    subplot(2,2,2);
    semilogy(f2, abs(CONVMod));
    title("Conventional AM in frequency domain");
    xlabel("w");
    
    subplot(2,2,3);
    semilogy(f2, abs(CONVNoise));
    title("Conventional AM modulated with noise");
    xlabel("w");
    
    subplot(2,2,4);
    semilogy(f, abs(CONVDemod));
    title("Conventional AM demodulated in frequency domain");
    xlabel("w");
    
    titlepm = ['modulation factor = ', num2str(modulation_factor(i))];
    sgtitle(titlepm);
end

%% PM

for i = 1:3
    [pmMod] = pm_Modulate(m,fs,max,f_cutoff,1 * modulation_factor(i));
    PMMod = fftshift(fft(pmMod)/fs2);
    
    [pmDemod_noiseless] = pm_Demodulate(Ac, pmMod, f_cutoff, wc, upt, fs2, 2);
        
    noise = sqrt(variance(1)) .* randn(length(m_upscale),1);
    noise = noise';
    
    pmNoise = pmMod + noise;
    PMNoise = fftshift(fft(pmNoise)/fs2);
    
    [pmDemod] = pm_Demodulate(Ac, pmNoise, f_cutoff, wc, upt, fs2,1 * modulation_factor(i));
    pmDemod = lowpass(pmDemod,2*pi*3000,fs2);
    PMDemod = fftshift(fft(pmDemod)/fs2);
    
    noiseless = (rms(pmDemod_noiseless) .^ 2);
    noisy = (rms(pmDemod - pmDemod_noiseless) .^ 2);
    
    snr_pm = (Ac.^2 * noiseless)/(variance(i)*20000);    
    snr_pm = 10 * log10(snr_pm);
    disp("SNR theoretical for PM (factor = " + modulation_factor(i) + "): " + snr_pm);
    
    snrpm = 10 * log10(noiseless/noisy);
    disp("SNR for PM with modulation factor " + modulation_factor(i) + ": " + snrpm);
    
    figure('position', [0, 0, 750, 750]);
    subplot(2,2,1);
    semilogy(f2, abs(fftshift(fft(m_upscale)/fs2)));
    xlabel('t (sec)');
    title("Original Signal");
    
    subplot(2,2,2);
    semilogy(f2, abs(PMMod));
    xlabel("Hz");
    title("PM Modulated in frequency domain");
    
    subplot(2,2,3);
    semilogy(f2, abs(PMNoise));
    xlabel("Hz");
    title("PM modulated with noise in frequency domain");
    
    subplot(2,2,4);
    semilogy(f, abs(PMDemod));
    xlabel("Hz");
    title("PM deodulated in frequency domain");
    
    titlepm = ['modulation factor = ', num2str(modulation_factor(i))];
    sgtitle(titlepm);
        
end

%% FM

for i = 1:3
    [fmMod] = fm_modulate(m,Ac,wc,fs,max,100000 * modulation_factor(i));
    FMMod = fftshift(fft(fmMod)/fs2);

    w = f2 / (2*pi); 
    [fmDemod_noiseless] = fm_demodulate(fmMod, fs2, f_cutoff,w);
    
    noise = sqrt(variance(1)) .* randn(length(m_upscale),1);
    noise = noise';
    
    fmNoise = fmMod + noise;
    FMNoise = fftshift(fft(fmNoise)/fs2);
    
    w = f2 / (2*pi); 
    [fmDemod] = fm_demodulate(fmNoise, fs2, f_cutoff, w);
    fmDemod = lowpass(fmDemod,2*pi*3000,fs2);
    FMDemod = fftshift(fft(fmDemod)/fs2);
    
    noiseless = (rms(fmDemod_noiseless) .^ 2);
    noisy = (rms(fmDemod - fmDemod_noiseless) .^ 2);
    
    snr_fm = (Ac.^2 * noiseless)/(variance(i)*20000);    
    snr_fm = 10 * log10(snr_fm);
    disp("SNR theoretical for FM (factor = " + modulation_factor(i) + "): " + snr_fm);
    
    snrfm = 10 * log10(noiseless/noisy);
    disp("SNR for FM with modulation factor " + modulation_factor(i) + ": " + snrfm);
    
    figure('position', [0, 0, 750, 750]);
    subplot(2,2,1);
    semilogy(f2, abs(fftshift(fft(m_upscale)/fs2)));
    xlabel('t (sec)');
    title("Original Signal");
    
    subplot(2,2,2);
    semilogy(f2, abs(FMMod));
    xlabel("Hz");
    title("FM Modulated in frequency domain");
    
    subplot(2,2,3);
    semilogy(f2, abs(FMNoise));
    xlabel("Hz");
    title("FM modulated with noise in frequency domain");
    
    subplot(2,2,4);
    semilogy(f, abs(FMDemod));
    xlabel("Hz");
    title("FM deodulated in frequency domain");
    
    titlepm = ['modulation factor = ', num2str(modulation_factor(i))];
    sgtitle(titlepm);
    
end