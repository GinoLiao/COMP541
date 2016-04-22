%Authentication Testing

close all;
clear;
clc;

encapFlag = 1;
compFlag = 0;
folderPath = './';
addpath(genpath('../'))
dataPath='../../../../Data/gestures/';

flagMemory=encapFlag;
flagMemory2=compFlag;

if(encapFlag)
    totalGestures = 17;
    numRuns = 30;
    cm = CalibrationCellMatrix(totalGestures, numRuns, dataPath);
  [ distanceMatrix ] = MatrixEncapsulation(dataPath, cm );
  
  %Reconstruct complexity
  if(compFlag)
      compMat = nan(1,totalGestures);
      for ind = 1:totalGestures
           compMat(ind) = cm{ind,6};
      end
      maxComp = max(compMat);
      minComp = min(compMat);
  end
  
  save myData.mat;
else
    load('myData.mat');
end

encapFlag = flagMemory;
compFlag = flagMemory2;
multiples = 2.5;
% multiples = 1:0.25:5;
complexityFactor = [1 1.5];
user = {'Gino', 'Joe', 'Henry'};


%%
% 95% Confidence Interval

numMultiples = length(multiples);
resMat = cell(length(multiples),1);
resMatFlat = zeros(length(multiples),3,2); %Multiple, person, accept/reject

for multind = 1:numMultiples

    %Calculate Authtication Thresholds
    numGestures = size(cm,1);
    if(compFlag)
        thresMat = zeros(numGestures,1);
        mid=0.5*(maxComp+minComp);
    end
    for gind = 1:numGestures
        dtwmean = cm{gind,4};
        dtwstd = cm{gind,5};
        if(compFlag)
            if(compMat(gind) > mid)
                compFactor=complexityFactor(1)+(compMat(gind)-mid)/(maxComp - mid)*(complexityFactor(2)-complexityFactor(1));
            else
                compFactor=complexityFactor(1)+(mid-compMat(gind))/(maxComp - minComp)*(complexityFactor(2)-complexityFactor(1));
            end
        else
            compFactor=1;
        end
        thresMat(gind) = multiples(multind)*compFactor*dtwmean+1.96*dtwstd/sqrt(30); % mean + 95% CI
%         thresMat(gind) = multiples(multind)*compFactor*dtwmean; % mean + 95% CI
    end

    %Check if meets thresholds
    [numPeople,numDays,numGestures,numAttempts] = size(distanceMatrix);
    resultMat = zeros(numPeople,numDays,numGestures,numAttempts);
    for pind = 1:numPeople
        for dind = 1:numDays
            for gind = 1:numGestures
                gThres = repmat(thresMat(gind),[numAttempts,1]);
                gAttempts = squeeze(distanceMatrix(pind,dind,gind,:));
                decision = gAttempts <= gThres;
                resultMat(pind,dind,gind,:) = decision;
            end
        end
    end


    %Produce Statistics
    intendedUser = 1;
    decisions = zeros(numPeople,numGestures,2); %[person,gesture,accept/reject]
    for pind = 1:numPeople
        for gind = 1:numGestures
            numAcceptances = sum(sum( resultMat(pind,:,gind,:) ));
            decisions(pind,gind,:) = [numAcceptances, numDays*numAttempts-numAcceptances];
        end
    end

    res=[squeeze(decisions(1,:,:)) squeeze(decisions(2,:,:)) squeeze(decisions(3,:,:)) ];
    res(:,2) = res(:,2) - 10;
    res(:,1:2) = res(:,1:2)./60*100;
    res(:,3:6) = res(:,3:6)./70*100;
    % display(res);
    
    resMat{multind} = res;
    %Multiple, person, accept/reject
    tempMean = mean(res);
    resMatFlat(multind,:,:) = [tempMean(1) tempMean(2);...
        tempMean(3) tempMean(4);...
        tempMean(5) tempMean(6)];
end

%%
%Plot results by gesture by multiples


% for gind=1:numGestures
%     mylegend=cell(numPeople,1);
%     myhandles=cell(numPeople,1);
%     cmap = hsv(numPeople);
%     legendCounter = 1;
%     figure(gind);
%     for pind=1:numPeople
%         myData = zeros(1,numMultiples);
%         for mind = 1:numMultiples
%             myData(mind) = resMat{mind}(gind,(pind-1)*2+1);
%         end
%         myhandles{legendCounter}=plot(multiples,myData,'Color',cmap(legendCounter,:));
%         hold on;
%         mylegend{legendCounter} =['User: ' user{pind}];
%         legendCounter = legendCounter+1;
%     end
%     title(['Gesture ' num2str(gind) ' Acceptance Percentages']);
%     xlabel('Threshold Multiple');
%     ylabel('Percentage of Attempts Accepted');
%     legend(mylegend,'Location','Northeast');
%     hold off;
% end

finalresult=[multiples' repmat(85,size(multiples')) resMatFlat(:,:,1) resMatFlat(:,:,2)];
display(finalresult);
