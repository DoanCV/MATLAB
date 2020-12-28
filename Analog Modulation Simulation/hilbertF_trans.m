function out = hilbertF_trans(signal, freq) %algorithm defined in class, based on definitions
H_w = -1j .* sign(freq); %F(1/pi*t)
out = (fftshift(fft(signal)) .* H_w); %real to remove the imginary part introduced to ifft
