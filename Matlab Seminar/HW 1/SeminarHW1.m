%%Pre-clearing
clc
clear
close all

%% Question 1
a = log10(26);

b = 5*exp(j*2*pi/3);

c = atan(sqrt(15))+34;

d = (1/2)*sqrt(3)+(1/2)*j;

x = [a ; b ; c ; d];

%% Question 2
f = b*d;

y = [real(f) imag(f) abs(f) angle(f)];

%% Question 3
g = x*y;

z = repmat((transpose(x)).*y, 4, 1);

%% Question 4
h = g+2*z;

k = g.*z;

l = g-2;

m = z';

%% Question 5 
n = rad2deg(angle(f));

linspace(1, n, 2000); 

1:0.3:n; 

