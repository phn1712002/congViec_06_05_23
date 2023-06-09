%% Clear
close all;
clc;
clear;

%% Xử lý dữ liệu
% Tải dữ liệu cho mô hình 
nameFile = 'dataModelRegression.xlsx';
data = readtable(nameFile);

% Chia dữ liệu thành các tập training và test
[dataTraining, dataTest] = splitData(data, 0.8, 1712);

% Chuẩn hóa dữ liệu
minMaxScale = myMinMaxScale;

minMaxScale = minMaxScale.fit(dataTraining);
dataTraining = minMaxScale.transform(dataTraining);
dataTest = minMaxScale.transform(dataTest);
data = minMaxScale.transform(data);

%% Khởi tạo mô hình
% Cấu trúc mạng nơ rơn
numFeatureInput = size(dataTraining, 2) - 1; 
layers = [
    % Layer Input
    featureInputLayer(numFeatureInput, 'Name', 'input')
    
    % Hidden Layer 1
    fullyConnectedLayer(128, 'Name', 'fc_1')
    reluLayer('Name','rl_1')
    % Hidden Layer 2
    fullyConnectedLayer(128, 'Name', 'fc_2')
    reluLayer('Name', 'rl_2')

    % Layer Output
    fullyConnectedLayer(1, 'Name', 'output')
    regressionLayer('Name', 'regression')
];
% Khởi tạo cách thức training
options = trainingOptions('adam');
options.MaxEpochs = 1000;
options.Verbose = false;
options.MiniBatchSize = 16;
% Khởi tạo cấu hình model
layersGraph = layerGraph(layers);


%% Huấn luyện model trên tập training
model = trainNetwork(dataTraining, layersGraph, options);

%% Kiểm tra trên tập test 
yPred = predict(model, dataTest);
disp(calcPerf(yPred, dataTest.Y));


%% Xuất đồ thị
figure;
plot(data.Y);
hold on;
yPred = model.predict(data);
plot(yPred);
