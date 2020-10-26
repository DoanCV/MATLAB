function returnValue = isOrthonormal(Vector)
[m,n]=size(Vector);
    for i = 1:n-1
        for j = i+1:n
            if(norm(Vector(i,:)) == 1 && dot(Vector(i,:),Vector(j,:)) < 0.00001)
                returnValue = 1;
            else 
                returnValue = 0;
            end
        end 
    end
end