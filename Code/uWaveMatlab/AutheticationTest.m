%Authentication Testing

%%
% 95% Confidence Interval

%Calculate Authtication Thresholds
numGestures = size(cm,1);
thresMat = zeros(numGestures,1);
for gind = 1:numGestures
    dtwmean = cm{gind,4};
    dtwstd = cm{gind,5};
    thresMat(gind) = dtwmean+1.96*dtwstd/sqrt(30); % mean + 95% CI
end

%Check if meets thresholds
[numPeople,numDays,numGestures,numAttempts] = size(distanceMatrix);
resultMat = zeros(numPeople,numDays,numGestures,numAttempts);
for pind = 1:numPeople
    for dind = 1:numDays
        for gind = 1:numGestures
            gThres = repMat(thresMat(gind),[1,numAttempts]);
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