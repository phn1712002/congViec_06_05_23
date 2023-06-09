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

%% Khởi tạo model SVR
model = trainRegressionModel(dataTraining);

%% Kiểm tra trên tập test 
yPred = model.predictFcn(dataTest);
disp(calcPerf(yPred, dataTest.Y));

%% Xuất đồ thị
figure;
plot(data.Y);
hold on;
yPred = model.predictFcn(data);
plot(yPred);