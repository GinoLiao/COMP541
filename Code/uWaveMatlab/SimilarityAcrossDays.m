% Similarity across the same person (17 gestures)

close all;
clear;
clc;

addpath(genpath('./functions/'));

folderPath = './';

% load cm 
load('functions/postprocess/30numcal.mat', 'cm','distanceMatrix');
% load('Data/gestures/cm041816.mat', 'cm');

% get distance matrix [Person(3) x Day(7) x GestureType(17) x Attempt(10)]
% [ distanceMatrix ] = MatrixEncapsulation('Data/gestures/', cm);

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
cmap = hsv(3);
% plot - average dtwDistance to calibrated dataset from day 1-7 for gesture#1-#17
myfig=figure;
for gesInd = 1:17 
%     clf; % clear current figure window
myfig=figure;

    % error bar refers to standard deviation
    % [gino (default-solid line), joe(dashed line), henry(dash-dot line)]
    gino = errorbar(similarityMatrix(gesInd,:,1,1),similarityMatrix(gesInd,:,1,2),'Color',cmap(1,:),'LineWidth',1,'Marker','o'); hold on
    joe = errorbar(similarityMatrix(gesInd,:,2,1),similarityMatrix(gesInd,:,2,2),'Color',cmap(3,:),'LineWidth',1,'Marker','o'); hold on
    henry = errorbar(similarityMatrix(gesInd,:,3,1),similarityMatrix(gesInd,:,3,2),'Color',cmap(2,:),'LineWidth',1,'Marker','o'); 
    % set up legend, title, x&y labels
%     title(['\fontsize{16} DTW distance across the days - ' fileMat{gesInd}],'FontWeight','bold');
    legend([gino joe henry], '\tiny Gino', '\tiny Joe \\ \tiny (Attacker)', '\tiny Henry \\ \tiny (Attacker)');
%     joe.LineStyle = '--';
%     henry.LineStyle = '-.';
    ylabel('DTW Distance');
    xlabel('Day');
    xlim([0 12]); 
%     savefig(['Data/plots/SimilarityPlot_' fileMat{gesInd} '.fig']);
    
    savefilename = ['../../Data/plots/SimilarityPlot_' fileMat{gesInd}];
    saveFigure( myfig, savefilename );
end
