clc
clear
close all

% Brian Doan, Derek Lee, Steven Lee
% Digital Signals Processing Fall 2020
% Project #5


%% Constants 

load pj2data
n = 1:size(y,2);
k = n;
w_k = 2*pi./k;


%% Test loaded data

figure();
tiledlayout(2,1);

% Plot y[n]
nexttile();
plot( n, y );
title( "y[n]" );
xlabel( "n" );
xlim( [ min(n) max(n) ] );

% Plot H(e^jw)^2
nexttile();
plot( k, Hejw2 );
title( "|H(e^{jw})|^2" );
xlabel( "k" );
ylabel( "Magnitude" );
xlim( [ min(k) max(k) ] );


%% Question A

y_1 = y(1:32);
c_y_1 = xcorr( y_1, y_1);
conv_y_1 = conv( y_1, fliplr(y_1) );

% Calculate scaling factor (uses 0.9 to see a difference between them)
scalingFac = 0.9*max(conv_y_1) / max(c_y_1);

% Plot
figure();
hold on;
plot( scalingFac*c_y_1, 'DisplayName', 'xcorr' );
plot( conv_y_1, 'DisplayName', 'conv' );
hold off;
title( "Autocorrelation of y_1" )
legend();


%% Problem A.1
% An estimate of a quantity is biased if its expected value is not equal to the quantity it estimates.

%xcorr provides the unbiased estimate, dividing by N-|m|, when you specify an 'unbiased' flag after the input sequences.
%the end points (near -(N-1) and N-1) suffer from large variance because xcorr computes them using only a few data poin
%Bias is more desireable because it avoids random large variations at the end points of the correlation sequence.

%% Problem A.2

n = 64;

% Part A
% the fourier transform of autocorrection is psd, which shows in phase that
% it is not real because it has a phase value. 

% Part B
d_y_1 = detAutoCorr(32,y);
C_y_1 = fft( c_y_1, n );
D_Y_1 = fft(d_y_1, n);
figure();
subplot(2,1,1)
plotMagnitude( 0:n-1, C_y_1, "C_{y_1}" );
hold on
plotMagnitude( 0:n-1, D_Y_1, "D_{y_1}" );
hold off
legend();
xlim( [ 0 n-1 ] );
subplot(2,1,2)
plotPhase( 0:n-1, C_y_1, "C_{y_1}" );
hold on
plotPhase( 0:n-1, D_Y_1, "D_{y_1}" );
xlim( [ 0 n-1 ] );
legend();
hold off;
%part C
%Repeat Part B

%% Problem A.3
    
figure();
hold on;

% Part A
D_y_1 = abs(D_Y_1);
plot(0:n-1, D_y_1, 'DisplayName', '|\phi(m)|');
% Part B
Y_1 = fft( y_1, n );
Y_1ejw2 = abs(Y_1).^2;
plot( 0:n-1, Y_1ejw2/n, 'DisplayName', '|Y_1(e^{jw})|^2' );

% Part C
y_2 = y(1:64);
Y_2 = fft( y_2, 64 );
Y_2ejw2 = abs(Y_2).^2;
plot( 0:n-1, Y_2ejw2/n, 'DisplayName', '|Y_2(e^{jw})|^2' );

hold off;
legend();
xlim( [ 0 n-1 ] );


%% Question B


%% Problem B.1

figure();
hb1 = downsample(Hejw2, 8);
hold on;
plot( 0:n-1, hb1, 'DisplayName', '|H(e^{jw})|^2' );
plot( 0:n-1, Y_1ejw2/64, 'DisplayName', '|Y_1(e^{jw})|^2' );
hold off;
title( "PDS of y[n] with 64 points" );
xlabel( "n" );
ylabel( "Magnitude" );
legend();

err1  = sum((hb1 - Y_1ejw2/64).^2 ) / 64;
disp( "The estimation error for B1 is: " + err1 );


%% Problem B.2

Y = fft(y,1024);
Yejw2 = abs(Y).^2;
Yejw2 = downsample(Yejw2, 2);
figure();
hold on;
plot( Hejw2, 'DisplayName', '|H(e^{jw})|^2' );
plot( Yejw2/1024, 'DisplayName', '|Y(e^{jw})|^2' );
hold off;
title( "PDS of y[n] with all points" );
xlabel( "n" );
ylabel( "Magnitude" );
err2  = sum((Hejw2 - Yejw2/1024).^2 ) / 512;
disp( "The estimation error for B2 is: " + err2 );
legend();
%for C.4
figure();
periodogram( y(1:64), rectwin(64), 512 );
%% Problem B.3
y_b3 = zeros(16,64);
figure;
hold on
for i = 1:16
    y_b = y((i-1)*32+1: (i-1)*32+32);
    y_b3(i,:) = abs(fft(y_b, 64)).^2;
end
y3 = sum(y_b3)/ 16/64;
b3Hejw2 = downsample(Hejw2,8);
plot (y3, 'DisplayName', '|Y(e^{jw})|^2');
plot (b3Hejw2, 'DisplayName', '|H(e^jw)|^2');
title('PDS averaging');
xlabel( "n" );
ylabel( "Magnitude" );
legend;
err3  = sum((b3Hejw2 - y3).^2 ) /64;

disp( "The estimation error for B3 is: " + err3 );
%% Problem B.4
figure;
hold on
y_b4 = xcorr(y,y,'unbiased');
y_b4 = y_b4(512-15: 512+15);
Y_b4 = abs(fft(y_b4,64));
plot (Y_b4, 'DisplayName', '|Y(e^{jw})|^2');
plot (hb1, 'DisplayName', '|H(e^jw)|^2');
title("Blackman-Tukey method");
xlabel( "n" );
ylabel( "Magnitude" );
legend;
err4 = sum((hb1-Y_b4).^2)/64;
disp( "The estimation error for B4 is: " + err4 );
%% Problem B.5
%a. From the results, we see that the error from B.4 is the least and
%therefore it is closest to the actual result. 

%b. Blackman-Tukey did well even without averaging because it took away the
%high variation on the edges, however the resolution is decreased due to
%the smaller window. 
figure;
hold on
%c
y_b5 = triang(31)'.* y_b4;
Y_b5 = abs(fft(y_b5,64));
plot (Y_b5,'DisplayName', '|Y(e^{jw})|^2');
plot (hb1, 'DisplayName', '|H(e^jw)|^2');
title("triangular window");
xlabel( "n" );
ylabel( "Magnitude" );
legend;

err5 = sum((hb1-Y_b5).^2)/64;
disp( "The estimation error for B5 is: " + err5 );

labelb = [1 2 3 4 5];
errortab = [err1 err2 err3 err4 err5];
TableB = table(labelb', errortab');
disp(TableB);
%The results changed due to the change of window (triang) and it minimize
%variation on the size while keeping the peak relative the same. 
%% Problem C.1
error3 = zeros(1,6);
for p = 2:7
   lev = levinson(y_b4, p);
   totsum = 0;
   for k = 1:p
       totsum = totsum + (lev(k))*exp(j*w_k*k);
   end
   H = 1./(1+totsum);
   phi = abs(H).^2;
   if p ==3
       p3 = phi;
   end
   error = sum((abs(Hejw2)-abs(phi)).^2)/512;
   error3(p-1) = error;
end
labelC1 = [2,3,4,5,6,7];
TableC1 = table(labelC1', error3');
disp(TableC1);
figure;
plot (w_k, p3);
xticks([0, pi, 2*pi]);
title("C1 for p3");    
%only did C1, no time for other 2.
%The error on P=3 is quite significant, while 2 and 6 are quite low on
%error relative to others (10 vs 12-13). 

