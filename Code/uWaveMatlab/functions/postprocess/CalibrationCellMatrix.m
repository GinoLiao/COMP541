function cm = CalibrationCellMatrix(totalGestures, numRuns)
    cm = cell(17,5);
    for indGes = 1:totalGestures
        [timeseries, indo, time, dtwmean, dtwstd] = GetOneCalibration('calibration/',indGes,numRuns);
        cm(indGes,:) = {timeseries, indo, time, dtwmean, dtwstd};
    end
end