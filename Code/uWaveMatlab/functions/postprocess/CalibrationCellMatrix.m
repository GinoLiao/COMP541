function cm = CalibrationCellMatrix(totalGestures, numRuns)
    cm = cell(17,5);
    range=1:totalGestures;
    excludeInds = [3 4];
    tic;
    for indGes = setxor(range,excludeInds)
        display(indGes);
        [timeseries, indo, time, dtwmean, dtwstd] = GetOneCalibration('calibration/',indGes,numRuns);
        toc;
        cm(indGes,:) = {timeseries, indo, time, dtwmean, dtwstd};
        toc;
    end
end