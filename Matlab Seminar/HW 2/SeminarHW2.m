clc
%% Number 1
vector1 = linspace(0, pi, 100);
vectorfunction1 = sin(2*vector1);
vector2 = linspace(0, pi, 1000);
vectorfunction2 = sin(2*vector2);

len100dydx = diff(vectorfunction1)./diff(vector1);
len1000dydx = diff(vectorfunction2)./diff(vector2);

a = 2*cos(2*vector1);
a(:,100) = [];
b = max(len100dydx - a);

c = 2*cos(2*vector2);
c(:,1000) = [];
d = max(len1000dydx - c);  %this is better

f = cumsum(vectorfunction1*(pi/100))-.5;
g = cumsum(vectorfunction2*(pi/1000))-.5;
h = cumtrapz(vectorfunction1*(pi/100))-.5;
k = cumtrapz(vectorfunction2*(pi/1000))-.5;

l = -1/2*cos(2*vector1);
m = -1/2*cos(2*vector2);

n = max(f-l); 
s = max(g-m);
t = max(h-l); %best one
u = max(k-m); 

figure;
plot(vector1,h);
title('Best approximation for integral of sin(2x)');

%% Number 2
A = 1:1:100;
MatrixA = reshape(A, 10, 10);
o = flipud(MatrixA);
MatrixA(3,:) = fliplr(MatrixA(3,:));
q = sum(MatrixA);
r = reshape(prod(MatrixA), 10, 1);
MatrixA(:,6) = [];

%% Number 3
fprintf('For Method 1:\n');
tic
Method1 = [];
for i=1:300
    for j=1:500
    Method1(i,j) = (i^3+j^3)/(i+j+2);
    end
end
toc

fprintf('For Method 2:\n');
tic
Method2 = zeros(300,500);
for i=1:300
    for j=1:500
    Method2(i,j) = (i^3+j^3)/(i+j+2);
    end
end
toc

fprintf('For Method 3:\n');
tic
i = 1:300;
j = 1:500;
[i1,j1] = meshgrid(j,i);
Method3 = (i1.^3.+j1.^3)./(i1+j1+2);
toc
