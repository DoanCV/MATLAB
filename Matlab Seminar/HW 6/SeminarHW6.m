clc 

%% Number 1
b = [0 .4 .25 1/7];
a = [1/3 0 -1/8 3/2];

[z,p,k] = tf2zp(b,a);
figure;
zplane(z,p);
title('Number 1: Pole zero');

%zeros = roots(b);
%poles = roots(a);
%figure;
%zplane(zeros,poles);

impulse = impz(b,a,50);
figure;
stem(impulse);
title('Number 1: Impulse Response');

n = 0:1:49;
x1 = (-4/5).^n;
figure;
stem(x1);
title('Before');

y1 = filter(b,a,x1);
figure;
stem(y1);
title('After');

y2 = conv(x1,impulse);
figure;
stem(y2);
xlim([0 50]);
title('Convolution');

%% Number 2
z_2 = [-1; 1];
p_2 = [0.9*exp(j*pi/2) 0.9*exp(-j*pi/2) 0.95*exp(j*5*pi/12) 0.95*exp(-j*5*pi/12) 0.95*exp(j*7*pi/12) 0.95*exp(-j*7*pi/12)];
[b_2,a_2] = zp2tf(z_2,p_2,0.01);

figure;
zplane(b_2,a_2);

[H,w] = freqz(b_2,a_2,1024);

H_dB = 20*log10(abs(H));
H_ph = unwrap(angle(H)*180/pi);

figure;
subplot(2,1,1);
plot(w,H_dB);
xlim([0 pi]);
xticks([0 pi/4 pi/2 3*pi/4 pi]);
xticklabels({'0','\pi/4','\pi/2','3\pi/4','\pi'});
title('Magnitude in dB');

subplot(2,1,2);
plot(w,H_ph);
xlim([0 pi]);
xticks([0 pi/4 pi/2 3*pi/4 pi]);
xticklabels({'0','\pi/4','\pi/2','3\pi/4','\pi'});
title('Phase');