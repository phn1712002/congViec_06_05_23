function [Training, Test] = splitData(X, ratioTrain, stateRandom)
    
    load("splitData", 'state', 'ratioTrainSave')
    if(state == stateRandom && ratioTrainSave == ratioTrain)
        load("splitData", 'Training', 'Test');
    else
        % Tính toán số lượng phần tử trong tập Training dựa vào phần trăm ratioTrain
        lengthTraining = floor(size(X, 1) * ratioTrain);

        % Trộn ngẫu nhiên bộ dữ liệu
        idx = randperm(size(X, 1));
        X = X(idx, :);

        % Chia dữ liệu về các tập
        Training = X(1:lengthTraining, :);
        Test = X(lengthTraining + 1:end, :);

        % Sao lưu trạng thái
        state = stateRandom;
        ratioTrainSave = ratioTrain;
        save("splitData", 'state', 'ratioTrainSave', 'Training', 'Test');
    end
end