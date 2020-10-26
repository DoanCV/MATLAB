function HW3function(x1,y1)
    firstDerivative = diff(x1)./diff(y1);
    firstTest = signSwitch(firstDerivative);
    xextrema = x1(firstTest);
    yextrema = y1(firstTest);
   
    secondDerivative = diff(firstDerivative);
    secondtest = signSwitch(secondDerivative);
    x1inflection = x1(secondtest);
    y1inflection = y1(secondtest);
    
    figure;
    plot(x1,y1,xextrema,yextrema,'ko',x1inflection,y1inflection,'r*')
end

function i = signSwitch(v)
    shiftedversion = circshift(v,1); %Third arguement is implicitly 1
    sign = shiftedversion .* v;
    i = find(sign < 0);
end