function [ distanceMatrix ] = MatrixEncapsulation_Model1(folderPath, cm )
% This function takes the path of parent folder (folderPath) where all the
% datasets for each days are & the cell matrix which contains all the
% calibrated datasets. It loops through all the datasets of different
% people, days, gestureTypes, and attempts, and then outputs the distance
% matrix which contains all the distances between calibrated dataset and
% attempted dataset per gesture.
%
%folderPath: should be ~/Data/model1/
%cm: cell matrix
%distanceMatrix: Person(2) x GestureType(4) x Attempt(10)

    % create and fill the output matrix with 0s
    distanceMatrix = nan(2,4,10);
    % get the filenames for gestures
    fileMat= {'num8','gesture7','ru','gesture17'}; 
    % usernames
    %user = {'gino', 'henry'};
    subfolderPath = {'Android&Pebble2/gino', 'Attacker2/henry'};
    
    tic;
    
    % whose datasets
    for userInd = 1:2
        display(['User:' num2str(userInd)]);
        % how many gestures
        for gesInd = 1:4
            display(['Ges:' num2str(gesInd)]);
            % attempts# per gesture
            for attempts = 1:10
                % load attempts data from mat file
                loadFile=[folderPath subfolderPath{userInd} '_' fileMat{gesInd} '_' num2str(attempts) '.mat'];
                matio = matfile(loadFile);
                try
                    accelerationData = matio.a;                    
                catch
                    distanceMatrix(userInd,gesInd,attempts) = NaN;
                    continue;
                end

                % load acceleration data matrix
                % quantization
                %if userInd == 1
                %    [~, accelerationData] = uWaveQuant (matio.t, accelerationData); 
                %end
                % leveling
%                 accLeveled = uWaveLeveling(accelerationData);
                % calculate the distance between attempts and calibrated using DTW
                % cm{gesInd,1} = time series of gesInd
                [Dist, ~, ~, ~] = dtw (cm{gesInd,attempts}, accelerationData);
                % fill the distance to the output matrix
                distanceMatrix(userInd,gesInd,attempts) = Dist;
            end
            toc;
        end
    end
    % finish processing
    % save the output matrix to the file
    outputFile = 'distanceMatrix.mat';
    save(outputFile,'distanceMatrix');

end

