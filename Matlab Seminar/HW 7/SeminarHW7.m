clear;
clc;
close all;

%% Number 1
t = linspace(0,2,1024);
f = reshape(1:50000,50000,1);
signal = sum(sin(2*pi*f.*t));

%% Number 2
%filterDesigner;

Fs = 100000;  % Sampling Frequency

Fpass = 10000;       % Passband Frequency
Fstop = 20000;       % Stopband Frequency
Apass = 5;           % Passband Ripple (dB)
Astop = 50;          % Stopband Attenuation (dB)
match = 'stopband';  % Band to match exactly

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.lowpass(Fpass, Fstop, Apass, Astop, Fs);
butterworth_lowpass = design(h, 'butter', 'MatchExactly', match);

[H,f] = freqz(butterworth_lowpass, 1024, Fs);
H_db_butterworth = 20*(log10(abs(H)));
H_ph_butterworth = unwrap(angle(H))*pi/180;

figure;
sgtitle('Butterworth Magnitude and Phase Plots');
subplot(3,1,1);
plot(f,H_db_butterworth);
xlabel('Hz');
title('Magnitude in dB');

subplot(3,1,2);
plot(f,H_ph_butterworth);
xlabel('Hz');
title('Phase Response');

y = filter(butterworth_lowpass,signal);
x = fft(y);
S = fftshift(abs(x))/1024;
F = Fs.*(-1024/2:1024/2-1)/1024;
subplot(3,1,3);
plot(F,S);
xlabel('Hz');
title('FFT of signal');

%% Number 3
Fs = 100000;  % Sampling Frequency

Fstop = 15000;       % Stopband Frequency
Fpass = 35000;       % Passband Frequency
Astop = 40;          % Stopband Attenuation (dB)
Apass = 2;           % Passband Ripple (dB)
match = 'passband';  % Band to match exactly

% Construct an FDESIGN object and call its CHEBY1 method.
h  = fdesign.highpass(Fstop, Fpass, Astop, Apass, Fs);
chebychev1 = design(h, 'cheby1', 'MatchExactly', match);

[H,f] = freqz(chebychev1, 1024, Fs);

H_db_chebychev1 = 20*(log10(abs(H)));
H_ph_chebychev1 = unwrap(angle(H))*pi/180;

figure;
sgtitle('Chebychev1 Magnitude and Phase Plots');
subplot(3,1,1);
plot(f,H_db_chebychev1);
xlabel('Hz');
title('Magnitude in dB');

subplot(3,1,2);
plot(f,H_ph_chebychev1);
xlabel('Hz');
title('Phase Response');

subplot(3,1,3);
y = filter(chebychev1,signal);
x = fft(y);
S = fftshift(abs(x))/1024;
F = Fs.*(-1024/2:1024/2-1)/1024;
subplot(3,1,3);
plot(F,S);
title('FFT of signal');
xlabel('Hz');

%% Number 4
Fs = 100000;  % Sampling Frequency

Fpass1 = 5000;        % First Passband Frequency
Fstop1 = 15000;       % First Stopband Frequency
Fstop2 = 35000;       % Second Stopband Frequency
Fpass2 = 45000;       % Second Passband Frequency
Apass1 = 5;           % First Passband Ripple (dB)
Astop  = 50;          % Stopband Attenuation (dB)
Apass2 = 5;           % Second Passband Ripple (dB)
match  = 'stopband';  % Band to match exactly

% Construct an FDESIGN object and call its CHEBY2 method.
h  = fdesign.bandstop(Fpass1, Fstop1, Fstop2, Fpass2, Apass1, Astop, ...
                      Apass2, Fs);
chebychev2 = design(h, 'cheby2', 'MatchExactly', match);

[H,f] = freqz(chebychev2, 1024, Fs);

H_db_chebychev2 = 20*(log10(abs(H)));
H_ph_chebychev2 = unwrap(angle(H))*pi/180;

figure;
sgtitle('Chebychev2 Magnitude and Phase Plots');
subplot(3,1,1);
plot(f,H_db_chebychev2);
xlabel('Hz');
title('Magnitude in dB');

subplot(3,1,2);
plot(f,H_ph_chebychev2);
xlabel('Hz');
title('Phase Response');

y = filter(chebychev2,signal);
x = fft(y);
subplot(3,1,3)
S = fftshift(abs(x))/1024;
F = Fs.*(-1024/2:1024/2-1)/1024;
subplot(3,1,3);
plot(F,S);
title('FFT of signal');
xlabel('Hz');

%% Number 5
Fs = 100000;  % Sampling Frequency

Fstop1 = 15000;   % First Stopband Frequency
Fpass1 = 20000;   % First Passband Frequency
Fpass2 = 30000;   % Second Passband Frequency
Fstop2 = 35000;   % Second Stopband Frequency
Astop1 = 50;      % First Stopband Attenuation (dB)
Apass  = 5;       % Passband Ripple (dB)
Astop2 = 50;      % Second Stopband Attenuation (dB)
match  = 'both';  % Band to match exactly

% Construct an FDESIGN object and call its ELLIP method.
h  = fdesign.bandpass(Fstop1, Fpass1, Fpass2, Fstop2, Astop1, Apass, ...
                      Astop2, Fs);
elliptic = design(h, 'ellip', 'MatchExactly', match);

[H,f] = freqz(elliptic, 1024, Fs);

H_db_elliptic = 20*(log10(abs(H)));
H_ph_elliptic = unwrap(angle(H))*pi/180;

figure;
subplot(3,1,1);
sgtitle('Elliptic Magnitude and Phase Plots');
plot(f,H_db_elliptic);
xlabel('Hz');
title('Magnitude in dB');

subplot(3,1,2);
plot(f,H_ph_elliptic);
xlabel('Hz');
title('Phase Response');

y = filter(elliptic,signal);
x = fft(y);
subplot(3,1,3);
S = fftshift(abs(x))/1024;
F = Fs.*(-1024/2:1024/2-1)/1024;
subplot(3,1,3);
plot(F,S);
title('FFT of signal');
xlabel('Hz');