function [out] = pm_Demodulate(Ac, m, f_cutoff, wc, t, fs, k)
N = length(m);
%T = N/(fs*40);
%t = linspace(0,T,N);

%fs2 = 40*fs;
fs2 = fs;
wd = linspace(-pi,pi,N);
f = wd * (fs2) / (2 * pi);

filter = (f_cutoff) ./ (1j * 2 * pi * f) + (f_cutoff);

iComponent = m .* sin(f_cutoff * 2 * pi * t);
IComponent = fftshift(fft(iComponent)/fs2);
rComponent = m .* cos(f_cutoff * 2 * pi * t);
RComponent = fftshift(fft(rComponent)/fs2);

%Ifiltered = lowpass(IComponent, f_cutoff, fs2);
Ifiltered = IComponent .* filter;
ifiltered = ifft(fftshift(Ifiltered)*fs2);

%Rfiltered = lowpass(RComponent, f_cutoff, fs2);
Rfiltered = RComponent .* filter;
rfiltered = ifft(fftshift(Rfiltered)*fs2);

phi_divided_by_k = atan(ifiltered ./ rfiltered)/k;

out = real(decimate(phi_divided_by_k,40));

%out = Ac * m .* sin(wc * t);
%out = lowpass(out,f_cutoff,fs);
%out = downsample(out,40);
end