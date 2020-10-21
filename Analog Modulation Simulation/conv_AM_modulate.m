function [conventional] = conv_AM_modulate(m, max, Ac, fs, wc)
N = length(m);
T = N/fs;

N2 = N * 40;
%fs2 = fs * 40;

t = linspace(0,T,N);
t2 = linspace(0,T,N2);

m_scale = m ./ max;

m_upscaled = interp1(t, m_scale, t2);

conventional = Ac * (1 + m_upscaled) .* cos(wc * t2);

end