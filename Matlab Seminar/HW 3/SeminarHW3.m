%%Pre-clearing
clc
clear
close all

%% Number 1
x = ones(100);
x = logical(x);
for i = 1:100
    for j = 1:100
        if or(sqrt((i-25)^2+(j-75)^2) < 10, sqrt((i-75)^2+(j-25)^2) < 10)
            [i1,j1] = meshgrid(j,i);
            x(i1,j1) = 0; 
        end
    end
end

y1 = ones(100);
y1 = logical(y1);
for i = 1:100
    for j = 1:100
        if or(sqrt((i-25)^2+(j-25)^2) < 10, sqrt((i-25)^2+(j-25)^2) < 10)
            [i1,j1] = meshgrid(j,i);
            y1(i1,j1) = 0; 
        end
    end
end

C = ones(100);
C = logical(C);
for i = 1:100
    for j = 1:100
        if sqrt((i-50)^2+(j-50)^2) > 10
            [i1,j1] = meshgrid(j,i);
            C(i1,j1) = 0; 
        end
    end
end

complementC = ~C;
figure;
imshow(complementC); 
figure;
imshow(x);
D = flipud(x); % I want dots from 2 in the other corners without changing the inequalities above
figure;
imshow(~C & D); %3 
figure;
imshow(y1 & x & D); %4
figure;
imshow(y1 & x & ~C & D); %5

%% Number 3
x1 = linspace(-3,3,10000);
y1 = x1.^5 - 8*x1.^3 + 10*x1 + 6;
HW3function(x1,y1);  %Name of function call matches file for the definition of functions

%% Number 2  
%(I moved number 2 to the bottom since I need definitions at the bottom)

x = sin(linspace(0,5,100)) + 1;
trueValue = 1.5;
findClosest(x,trueValue);

function [val,ind] = findClosest(x,trueValue)
    y = abs(x-trueValue);
    closest = min(y);  %I cannot simply reuse y with min for searching since it is now a new vetor of differences
    ind = find(y == closest); 
    val = x(ind);
end