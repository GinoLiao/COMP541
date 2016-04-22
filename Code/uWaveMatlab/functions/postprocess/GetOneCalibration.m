%Finds calibration parameters for one Gesture
%Inputs:
%   folderPath:String = Path to calibration data from working directory
%   gestureInd:Int = Gesture index
%   numRuns:Int = number of runs in include in calibration
%Outputs:
%   timeseries:(timexDimension) = acceleration data for comparison
%   indo = Attempt index used for timeseries
%   time = Time points associated with the timeseries
%   dtwmean = maximum average distance from calibration data
%   dtwstd = associated standard deviation for dtwmean
%   compm = average number of extreme (3 dimensions averaged together)
%   compstd = standard deviation for compm


function [timeseries, indo, time, dtwmean, dtwstd,compm,compstd] = GetOneCalibration(folderPath,gestureInd,numRuns)
    %Suppress warnings from mobile device object missing
    warning('off','all');

    %Initialize data matrices
    meanStdMat = zeros(numRuns,2);
    extremaCount = zeros(numRuns,3);
    
    %Get File names for each gesture
    fileMat=GetFileNames();
    filename = fileMat{gestureInd};
    
    %Main Loop
    for ind = 1:numRuns
        %Load File "ind"
        loadFile=[folderPath 'gino_' filename '_' num2str(ind) '.mat'];
        matio=matfile(loadFile);
        a1 = matio.a;
        
        %Quantization and leveling
%         [tout1,Q1] = uWaveQuant(matio.t,matio.a);
        a1 = uWaveLeveling(matio.a);
        
        %Compare attempt "ind" vs attempt "subind"
        innerMat = zeros(numRuns-1,1);
        for subind = 1:numRuns
            %Ensure not comparing the same file
            if(subind ~= ind)
                %Load File "subind"
                newFile =[folderPath 'gino_' filename '_' num2str(subind) '.mat'];
                matio=matfile(newFile);
                a2=matio.a;
                
                %Quantization and leveling
%                 [tout2,Q2] = uWaveQuant(matio.t,matio.a);
                a2 = uWaveLeveling(matio.a);

                %Calculate distance
                [Dist, ~, ~, ~] = dtw(a1,a2);
                
                %Store distance
                if(subind >ind) %Skips when ind=subind
                    innerMat(subind-1) = Dist;
                else
                    innerMat(subind) = Dist;
                end
            end
        end
        meanStdMat(ind,:) = [mean(innerMat) std(innerMat)];
        
        %Extrema counting
        for subind = 1:3
            temp = smooth(a1(:,subind));
            [maxVal,~,minVal,~]=extrema(temp);
            extremaCount(ind,subind) = length(maxVal) + length(minVal);
        end
    end
    
    %Get maximum mean and standard deviation for threshold setting
    [dtwmean,indo] = max(meanStdMat(:,1));
    dtwstd = meanStdMat(indo,2);
    
    %Get 95th percentile
    [dtwmean]=prctile(meanStdMat(:,1),85);
    dtwstd = meanStdMat(indo,2);
    
    %Average number of extrema for complexity measure
    mid=mean(extremaCount);
    compm = mean(mid);
    compstd = std(mid);
    
    %Store the time series with smallest distance as reference
    [~,indo] = min(meanStdMat(:,1));
%     [dtwmean,indo] = min(meanStdMat(:,1));
%     dtwstd = meanStdMat(indo,2);
    loadFile = [folderPath 'gino_' filename '_' num2str(indo) '.mat'];
    matio=matfile(loadFile);
    time=matio.t;
    timeseries=matio.a;
    
    %Turn warnings back on
    warning('on','all');
end