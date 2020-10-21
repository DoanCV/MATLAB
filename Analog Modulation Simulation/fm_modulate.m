function [out] = fm_modulate(m,Ac,wc,fs,a,k)
N = length(m);
T = N/fs;
t = linspace(0,T,N);
N2 = 40*N;
fs2 = 40*fs;
t2 = linspace(0,T,N2);

m_scale = m./a;
m_upscale = interp1(t, m_scale, t2);

phase = 2*pi*k*cumsum(m_upscale)/fs2;

out = Ac * cos(wc*t2 + phase);
end