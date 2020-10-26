function [e] = gramSchmidt(v)
[m,n] = size(v);
e = zeros(m,n);
u = zeros(m,n);
u(:,1) = v(:,1);
e(:,1) = u(:,1)/norm(u(:,1));
    for i=2:n
        u(:,i) = v(:,i);
        for j = 1:i-1
            projection = (inprod(v(:,i),u(:,j))/inprod(u(:,j),u(:,j))).*u(:,j);
            u(:,i) = u(:,i) - projection;
        end
        e(:,i) = u(:,i)/norm(u(:,i));
    end
end



