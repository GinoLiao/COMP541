function [t,Q] = uWaveQuant(tIn,d)
    %Constants
    windowSize = 500; %milliseconds
    stepSize = 150; %milliseconds
    convertWindow = windowSize/1000; %window size in seconds
    convertStep = stepSize/1000; %step size in seconds
    
    %Produce reduced time points
    t=min(tIn)+convertStep:convertStep:max(tIn); %time values out (s)
    
    %Iterate through reduced time points to produce average
    Q = zeros(length(t),3);
    for ind = 1:length(t)
        curT = t(ind); %Current time
        curInds = find(tIn <= curT & tIn >= curT-convertWindow); %Find indices within time window
        for k = 1:3
            curD = d(curInds,k); %Associated time series data
            Q(ind,k) = mean(curD); %Find mean
        end
    end
end