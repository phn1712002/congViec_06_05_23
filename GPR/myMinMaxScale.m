classdef myMinMaxScale
    properties (SetAccess = private)
        maxVal
        minVal
    end

    methods
        
        function showMinMax(obj)
            disp(num2str([obj.maxVal, obj.minVal]))
        end
        
        function obj = fit(obj, data)
            lengthYData = size(data,2);
            obj.maxVal = max(data{:, [1:lengthYData - 1]}, [], 1);
            obj.minVal = min(data{:, [1:lengthYData - 1]}, [], 1);
        end
        
        
        function data = transform(obj, data)
            lengthYData = size(data, 2);
            newData = (data{:, [1:lengthYData - 1]} - obj.minVal) ./ (obj.maxVal - obj.minVal);
            addValueOutput = zeros(size(data, 1), lengthYData);
            addValueOutput(:, [1:lengthYData - 1]) = newData;
            addValueOutput(:, lengthYData) = data{:, lengthYData};
            variableNames = data.Properties.VariableNames;
            data = array2table(addValueOutput);
            data.Properties.VariableNames = variableNames;
        end
        
  
    end
end