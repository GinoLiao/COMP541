%Authentication Testing

clear;
clc;

calibrationFlag = 1;
encapFlag = 1;
folderPath = './';

if(calibrationFlag)
    totalGestures = 17;
    numRuns = 30;
    cm = CalibrationCellMatrix(totalGestures, numRuns);
end

if(encapFlag)
  [ distanceMatrix ] = MatrixEncapsulation(folderPath, cm )
end

if(~encapFlag)
    load('distanceMatrix041716.mat');
end


%%
% 95% Confidence Interval

%Calculate Authtication Thresholds
numGestures = size(cm,1);
thresMat = zeros(numGestures,1);
for gind = 1:numGestures
    dtwmean = cm{gind,4};
    dtwstd = cm{gind,5};
    thresMat(gind) = 1.5*dtwmean+1.96*dtwstd/sqrt(30); % mean + 95% CI
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

res=[squeeze(decisions(1,:,:)) squeeze(decisions(3,:,:)) squeeze(decisions(2,:,:))];
res(:,2) = res(:,2) - 10;
res(:,1:2) = res(:,1:2)./60*100;
res(:,3:6) = res(:,3:6)./70*100;
display(res);