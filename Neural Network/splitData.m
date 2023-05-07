function [Training, Test] = splitData(X, ratioTrain)
    % Tính toán số lượng phần tử trong tập Training dựa vào phần trăm ratioTrain
    lengthTraining = floor(size(X, 1) * ratioTrain);

    % Trộn ngẫu nhiên bộ dữ liệu
    idx = randperm(size(X, 2));
    X = X(:, idx);

    % Chia dữ liệu về các tập
    Training = X(1:lengthTraining, :);
    Test = X(lengthTraining + 1:end, :);
    
end