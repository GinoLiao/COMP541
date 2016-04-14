function [timeseries, indo, time, dtwmean, dtwstd] = GetOneCalibration(folderPath,gestureInd,numRuns)
    meanStdMat = zeros(numRuns,2);
    fileMat=GetFileNames();
    filename = fileMat(gestureInd,2);
    
    for ind = 1:numRuns
        load([folderPath 'gino_' filename '_' num2str(ind) '.mat']);
        holda = a;
        innerMat = zeros(numRuns,1);
        for subind = 1:numRuns
            if(subind ==ind)
                 innerMat(subind) = inf;
            else
                load([folderPath 'gino_' filename '_' num2str(subind) '.mat']);
                [Dist, ~, ~, ~] = dtw(holda,a);
                innerMat(subind) = Dist;
            end
        end
        meanStdMat(ind,:) = [mean(innerMat) std(innerMat)];
    end
    
    [dtwmean,indo] = min(meanStdMat(:,1));
    dtwstd = meanStdMat(indo,2);
    
    load([folderPath 'gino_' filename '_' num2str(indo) '.mat']);
    time=t;
    timeseries=a;
end