function [out] = fm_demodulate(m, fs, f_cutoff, w)
fs2 = 40*fs;

y = real(ifft(fft(m).*(1j*w)));

y(y < 0) = 0;

out = decimate(lowpass(y,f_cutoff * 40, fs2), 40);

%out = lowpass(y, f_cutoff, fs);
%out = downsample(y,40);
%out = lowpass(out, f_cutoff, fs2);
end