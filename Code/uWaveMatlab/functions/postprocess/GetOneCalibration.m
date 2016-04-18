function [timeseries, indo, time, dtwmean, dtwstd,compm,compstd] = GetOneCalibration(folderPath,gestureInd,numRuns)
    warning('off','all');

    meanStdMat = zeros(numRuns,2);
    extremaCount = zeros(numRuns,3);
    fileMat=GetFileNames();
    filename = fileMat{gestureInd};
    
    for ind = 1:numRuns
        loadFile=[folderPath 'gino_' filename '_' num2str(ind) '.mat'];
        matio=matfile(loadFile);
        a1 = matio.a;
        %Q L
%         [tout1,Q1] = uWaveQuant(matio.t,matio.a);
%         a1 = uWaveLeveling(matio.a);
        innerMat = zeros(numRuns-1,1);
        for subind = 1:numRuns
            if(subind ~= ind)
                newFile =[folderPath 'gino_' filename '_' num2str(subind) '.mat'];
                matio=matfile(newFile);
                a2=matio.a;
%                 [tout2,Q2] = uWaveQuant(matio.t,matio.a);
%                 a2 = uWaveLeveling(matio.a);
                %Q L
                [Dist, ~, ~, ~] = dtw(a1,a2);
                
                if(subind >ind)
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
            [maxVal,maxInd,minVal,minInd]=extrema(temp);
            extremaCount(ind,subind) = length(maxVal) + length(minVal);
        end
    end
    
    [dtwmean,indo] = max(meanStdMat(:,1));
    dtwstd = meanStdMat(indo,2);
    
    [~,indo] = min(meanStdMat(:,1));
    
    loadFile = [folderPath 'gino_' filename '_' num2str(indo) '.mat'];
    matio=matfile(loadFile);
    time=matio.t;
    timeseries=matio.a;
    
    warning('on','all');
end