function cm = CalibrationCellMatrix(totalGestures, numRuns)
    cm = cell(17,5);
    range=1:totalGestures;
    excludeInds = [];
    tic;
    for indGes = setxor(range,excludeInds)
        display(indGes);
        [timeseries, indo, time, dtwmean, dtwstd] = GetOneCalibration('newCalData/',indGes,numRuns);
        toc;
        cm(indGes,:) = {timeseries, indo, time, dtwmean, dtwstd};
        toc;
    end
end