%% Homework 3 MATLAB
%Preclean
clear;
clc;
close all;

%% Number 6/7/8

M = 1000;
variance = 10000;
noise = variance * randn(1, 10000);

[auto_correlation , PSD] = auto_PSD(noise, M);

w = linspace(-pi*1000,pi*1000, 2*M + 1);

m = -M:M;
figure;
stem(m,auto_correlation);
xlabel("m");
xlim([-1000,1000]);
title("Number 6 Auto Correlation");

figure;
semilogy(w,abs(PSD));
xlabel("w");
title("Number 8 PSD");

%Integration is multiply by 1/jw
%LTI so |H(w)|^2 * Sx(w) = Sy(w)
integral = (1./w.^2).*PSD;
figure;
semilogy(w,abs(integral));
xlabel("w");
title("Number 8 'integral'");

function [auto_correlation , PSD] = auto_PSD(input, M)
    auto_correlation = zeros(1, 2*M + 1);
    N = length(input);
    for m_pos = 0:M
        auto_correlation(m_pos+M+1) = (1/(N-m_pos)) * sum(input(1:N-m_pos) .* input(m_pos+1:N));
    end
    
    for m_neg = -M:-1
        auto_correlation(abs(m_neg)) = (1/(N-abs(m_neg))) * sum(input((abs(m_neg)+1):N) .* input(1:N+m_neg));
    end
    
    m_neg = -M:1:M;
    w = linspace(-pi, pi, 2*M + 1);
    
    PSD = zeros(1,2*M + 1);
    PSD = PSD + (auto_correlation .* exp(-1j*w.*m_neg/(2*M+1)));
end



