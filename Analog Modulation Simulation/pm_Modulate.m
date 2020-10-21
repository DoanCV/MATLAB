function [out] = pm_Modulate(signal, fs, Ac, fc, k)
N = length(signal);
T = N/fs;
signal = signal ./ max(signal);

t = linspace(0,T,N);
upt = linspace(0,T,N*40);

%wd = linspace(-pi,pi,N*40);
%f = wd*(fs*40) / (2*pi);

signal = interp1(t, signal, upt);
out = Ac*cos(2*pi*upt*fc + k.*signal);

end 
