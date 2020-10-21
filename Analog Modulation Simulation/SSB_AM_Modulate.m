function [U_ussb, upt] = SSB_AM_Modulate(m,a,Ac,fs,wc) 
N = length(m);
T = N/fs;
m_scale = m ./ a; %divide each value by max to gurantee max is 1 and the rest are scaled similarly
fs2 = fs * 40; %upsample
upN = N * 40;
t = linspace(0,T,N);
upt = linspace(0,T,upN);

m_upscale = interp1(t,m_scale,upt);

H_m_t = real(hilbertT_trans(hilbertF_trans(m_upscale,fs2))); 

U_ussb = Ac *( m_upscale .* cos(wc * upt) + H_m_t .* sin(wc * upt));
U_ussb = U_ussb + cos(wc * upt);
end
