%% Clear
close all;
clc;
clear;

%% Xử lý dữ liệu
% Tải dữ liệu cho mô hình 
nameFile = 'dataModelRegression.xlsx';
data = readtable(nameFile);

% Chia dữ liệu thành các tập training và test
[dataTraining, dataTest] = splitData(data, 0.8);


%% Kiểm tra trên tập test 
yPred = predict(model, dataTest);
pref = calcPerf(yPred, dataTest.Y);
print(pref);