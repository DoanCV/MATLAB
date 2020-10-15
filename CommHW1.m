%% Homework 1 MATLAB
%Preclean
clear;
clc;
close all;

%% Number 6
% Uncomment to get user input for other T and N
%period = 'Input a period: '; 
%T = input(period);
%samples = 'Input number of samples: ';
%N = input(samples);

%Demo values
T = 1;
N = 2048;

%From demo
f_s = N/T;
t = linspace(-10,10,N);
w_d = linspace(-pi,pi,N);
f = w_d*f_s/(2*pi); %wd = 2*pi*f/fs

%rect-like function to get 0 everywhere else
rect = t;
rect(rect>T|rect<0) = 0;
zero_elsewhere = find(rect == 0);
rect(rect > 0) = 1; %set to 1 so when multiplied it keeps one period the same, otherwise 0

x = cos(2*pi*f_s*t);
x(zero_elsewhere) = 0;

%new rect to account for shifting left 3 from x to y
a = t-3;
rect_y = a;
rect_y(rect_y>T|rect_y<0) = 0;
zero_elsewhere_y = find(rect_y == 0);
rect_y(rect_y > 0) = 1;

%y = abs(cos(2*pi*f_s*(t+3)));
x_of_t_plus_3 = cos(2*pi*f_s*a); 
y = abs(x_of_t_plus_3);
y(zero_elsewhere) = 0;

Y = fft(y.*rect);
X = fft(x.*rect);
Ys = fftshift(Y);
Xs = fftshift(X);

% Plots of magnitude and phase
% Unwrapped phase
figure;
subplot(2,2,1);
plot(f,unwrap(angle(Xs)));
title('Phase X');
xlabel('Frequency (Hz)');

subplot(2,2,2);
plot(f,unwrap(angle(Ys)));
title('Phase Y');
xlabel('Frequency (Hz)');

subplot(2,2,3);
plot(f,abs(Xs));
title('Magnitude X');
xlabel('Frequency (Hz)');

subplot(2,2,4);
plot(f,abs(Ys));
title('Magnitude Y');
xlabel('Frequency (Hz)');

sgtitle('Number 6 plots');
%% Number 5 
%find shifted frequency range and calculate norm of Fourier over it
new_indicies = find(f > (-f_s/2) & f < (f_s/2));
norm_a = (sum(abs(X(new_indicies).^2))) * (T/N);
norm_b = (sum(abs(Xs(new_indicies).^2))) * (T/N);
%norm a == norm b
%I think I have to scale x or X by something to get the 1/2 that comes from cos that you mentioned but I am not sure what
%% Number 7
z = y .* cos(64*pi*t + pi/3); % theta = pi/3
Z = fft(z);
Zs = fftshift(Z);

%Plots
figure;
subplot(2,2,1);
plot(f,abs(Zs));
title('Magnitude Z');
xlabel('Frequency (Hz)');

subplot(2,2,2);
plot(f,unwrap(angle(Zs)));
title('Phase Z');
xlabel('Frequency (Hz)');

subplot(2,2,3);
plot(f,unwrap(angle(Ys)));
title('Phase Y');
xlabel('Frequency (Hz)');

subplot(2,2,4);
plot(f,abs(Ys));
title('Magnitude Y');
xlabel('Frequency (Hz)');

sgtitle('Number 7 plots');

f_pass = f_s/2;

figure;
bandpass(z, [f_pass/4 f_pass/2], f_s);
title('Bandpass');
xlabel('Frequency (Hz)');

%baseband signal is lowpass signal
figure;
baseband_signal = lowpass(z, f_pass/2, f_s); %this applies inphase and quadrature multiplication to original y signal
plot(f,baseband_signal);
title('Baseband');
xlabel('Frequency (Hz)');
%% Number 8
H_x_f = hilbertF_trans(x, f); %Call to hilbert_trans function which is my hilbert implementation in freq domain
H_y_f = hilbertF_trans(y, f);
H_z_f = hilbertF_trans(z, f);

H_x_t = hilbertT_trans((H_x_f)); %Call to hilbert_trans function which is ifft of freq domain version
H_y_t = hilbertT_trans((H_y_f));
H_z_t = hilbertT_trans((H_z_f));

%plots
figure;
subplot(3,2,1);
plot(f, abs(H_x_f));
title('Hilbert Transform x, frequency domain');
xlabel('Frequency (Hz)');

subplot(3,2,2);
plot(t, abs(H_x_t));
title('Hilbert Transform x, time domain');
xlabel('time');

subplot(3,2,3);
plot(f, abs(H_y_f));
title('Hilbert Transform y, frequency domain');
xlabel('Frequency (Hz)');

subplot(3,2,4);
plot(a, abs(H_y_t));
title('Hilbert Transform y, time domain');
xlabel('time');

subplot(3,2,5);
plot(f, abs(H_z_f));
title('Hilbert Transform z, frequency domain');
xlabel('Frequency (Hz)');

subplot(3,2,6);
plot(a, abs(H_z_t));
title('Hilbert Transform z, time domain');
xlabel('time');

A = dot(x, real(H_x_t)); %Real part is close to 0 for A, B and C
B = dot(y, real(H_y_t)); %The dot product is 0, with roundoff, so they are orthogonal
C = dot(z, real(H_z_t)); %This is what hilbert transform does since it is a rotation by 90 degrees. 

%check if x,y,z were properly written since y and z depend on x
%figure;
%plot(t, x);
%figure;
%plot(a, y);
%figure;
%plot(a, z);