function [t,Q] = uWaveQuant(tIn,d)
    %Constants
    windowSize = 0.050; %milliseconds
    stepSize = 30; %milliseconds
    convertWindow = windowSize/1000; %window size in seconds
    convertStep = stepSize/1000; %step size in seconds
    
    %Produce reduced time points
    t=min(tIn)+convertStep:convertStep:max(tIn); %time values out (s)
    
    %Iterate through reduced time points to produce average
    for ind = 1:length(t)
        curT = t(ind); %Current time
        curInds = find(tIn <= curT & tIn >= curT-convertWindow); %Find indices within time window
        curD = d(curInds); %Associated time series data
        Q(ind) = mean(curD); %Find mean
    end
end