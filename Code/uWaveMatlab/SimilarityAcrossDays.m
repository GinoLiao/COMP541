% Similarity across the same person (17 gestures)

clear;
clc;

folderPath = './';

% load cm 
load('Data/gestures/cm041816.mat', 'cm');

% get distance matrix [Person(3) x Day(7) x GestureType(17) x Attempt(10)]
[ distanceMatrix ] = MatrixEncapsulation('Data/gestures/', cm);

% calculate mean and std (GESTURExDAYxPERSONxMEAN/STD)
similarityMatrix = zeros(17,7,3,2);
for who = 1:3
    for day = 1:7
        for gesInd = 1:17
            % mean & standard deviation
            similarityMatrix(gesInd,day,who,:) = [nanmean(distanceMatrix(who,day,gesInd,:)) nanstd(distanceMatrix(who,day,gesInd,:))];
        end
    end
end

% save similarityMatrix into mat file
save('similairtyMatrix.mat','similarityMatrix');

fileMat = GetFileNames(); 
% plot - average dtwDistance to calibrated dataset from day 1-7 for gesture#1-#17
for gesInd = 1:17 
    clf; % clear current figure window

    % error bar refers to standard deviation
    % [gino (default-solid line), joe(dashed line), henry(dash-dot line)]
    gino = errorbar(similarityMatrix(gesInd,:,1,1),similarityMatrix(gesInd,:,1,2)); hold on
    joe = errorbar(similarityMatrix(gesInd,:,2,1),similarityMatrix(gesInd,:,2,2)); hold on
    henry = errorbar(similarityMatrix(gesInd,:,3,1),similarityMatrix(gesInd,:,3,2)); 
    % set up legend, title, x&y labels
    title(['\fontsize{16} DTW distance across the days - ' fileMat{gesInd}],'FontWeight','bold');
    legend([gino joe henry], 'Gino', 'Joe', 'Henry');
    joe.LineStyle = '--';
    henry.LineStyle = '-.';
    ylabel('DTW distance','FontSize',12);
    xlabel('Day','FontSize',12);
    savefig(['Data/plots/SimilarityPlot_' fileMat{gesInd} '.fig']);
end
