function [demodSSB] = SSB_AM_Demodulate(m, f_cutoff, wc, t, fs)
out = m .* cos(wc * t);
out = lowpass(out,f_cutoff,fs);
%out = highpass(out,2,fs);
demodSSB = downsample(out,40);
end