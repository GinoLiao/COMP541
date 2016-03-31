function dataOut=uWaveLeveling(dataIn)
    %Thresholds of level quantization
    thres=[-19.6000000000000,-17.6400000000000,-15.6800000000000,...
        -13.7200000000000,-11.7600000000000,-9.80000000000000,...
        -8.82000000000000,-7.84000000000000,-6.86000000000000,...
        -5.88000000000000,-4.90000000000000,-3.92000000000000,...
        -2.94000000000000,-1.96000000000000,-0.980000000000000,0,...
        0.980000000000000,1.96000000000000,2.94000000000000,...
        3.92000000000000,4.90000000000000,5.88000000000000,...
        6.86000000000000,7.84000000000000,8.82000000000000,...
        9.80000000000000,11.7600000000000,13.7200000000000,...
        15.6800000000000,17.6400000000000,19.6000000000000];
    bins=-16:1:16; %Bins each measurement can be placed in
    
    %Initialize result
    [numEntries,numDims]=size(dataIn);
    dataOut = zeros(size(dataIn));
    
    %Iterate over each entry
    for i=1:numEntries
        for k=1:numDims
            %Find smallest bin it can fit in
            mydiff = thres-dataIn(i,k);
            inds=find(mydiff>=0);
            
            %Update data with bin value
            if(isempty(inds)) %Reached end, put in largest bin
                dataOut(i,k)=bins(end);
            else %Otherwise, place in smallest possible bin
                dataOut(i,k)=bins(inds(1));
            end
        end
    end
end