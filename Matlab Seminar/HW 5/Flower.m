classdef Flower
    properties 
        petalWidth double;
        petalLength double;
        sepalWidth double;
        sepalLength double;
        species char;
    end
    methods
        function obj = Flower(pW,pL,sW,sL,s)
        obj.petalWidth = pW;
        obj.petalLength = pL;
        obj.sepalWidth = sW;
        obj.sepalLength = sL;
        obj.species = s;
        end
        
        function a = getSWidth(obj)
        a = obj.sepalWidth;
        end
        
        function statement = report(obj) 
        statement = sprintf('The length and width of its sepal are %s cm and %s cm respectively, while the length and width of its petal are %s cm and %s cm. It belongs to the %s species.', string(obj.petalWidth),string(obj.petalLength), string(obj.sepalWidth),string(obj.sepalLength),string(obj.species));
        end
    end
end