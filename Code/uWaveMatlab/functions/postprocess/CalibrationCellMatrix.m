%Iterate over all calibration data to produce data output
%Inputs:
%   totalGestures = Number of gestures in library
%   numRuns = Number of calibration runs
%Ouputs:
%   cm = Cell Matrix with calibration data {timeseries, indo, time, dtwmean, dtwstd, compm, compstd}

function cm = CalibrationCellMatrix(totalGestures, numRuns,dataPath)
    %Initialize output
    cm = cell(17,7);
    
    %Sets which gestures to include in calibration
    range=1:totalGestures;
    excludeInds = [];
    
    %Start timer
    tic; 
    
    %Iterate over all desired gestures
    for indGes = setxor(range,excludeInds)
        %Index for debugging
%         display(indGes);
        
        %Get calibration data and store
        [timeseries, indo, time, dtwmean, dtwstd,compm,compstd] = GetOneCalibration([dataPath 'newCalData/'],indGes,numRuns);
        cm(indGes,:) = {timeseries, indo, time, dtwmean, dtwstd, compm, compstd};
        
        %Display time elapsed for debugging
        toc;
    end
end