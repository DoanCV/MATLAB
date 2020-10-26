function [proj] = orthoProj(Vector,matrix)
[m,n] = size(Vector);
proj = 0;
    for i = 1:n
        projection_vector = (inprod(Vector,matrix(:,i))/inprod(matrix(:,i),matrix(:,i))).*matrix(:,i);
        proj = proj + projection_vector;
    end
end
