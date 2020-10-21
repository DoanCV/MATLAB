function [amDemod] = conv_AM_demodulate(m, fs, f_cutoff)
m(m<0) = 0;
f = lowpass(m,f_cutoff,fs);
%f = highpass(f,5,fs);
amDemod = downsample(f,40);
end