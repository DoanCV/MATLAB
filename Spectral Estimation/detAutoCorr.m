function[phi_y1] = detAutoCorr(N,y)
    phi_y1 = zeros(1,N);
    y1 = y(1:N);
    for i = 1:N
        phi_y1(i) = sum(y1(1:N-i+1) .* y1(i:N)) / N;
    end
    phi_y1 = [flip(phi_y1) phi_y1(2:end)];

end
