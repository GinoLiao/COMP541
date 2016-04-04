% need to check~~
function dout = Rot2NormCoord(azimuth,pitch,roll,din)
    [numData,~] = size(din);
    
    dout=zeros(size(din));
    
    % Quaternion Variable setup
    a = cosd(pitch/2);
    vectorLen = sqrt((din[1])^2+(din[2])^2+(din[3])^2);
    b = -1/vectorLen * din[1] * sind(pitch/2);
    c = -1/vectorLen * din[2] * sind(pitch/2);
    d = -1/vectorLen * din[3] * sind(pitch/2);
    
    %Get rotation matrix (Source:
    %http://www.chrobotics.com/library/understanding-quaternions)
    RB_I=[a^2+b^2-c^2-d^2 2*b*c-2*a*d 2*b*d+2*a*c;...
        2*b*c+2*a*d a^2-b^2+c^2-d^2 2*c*d-2*a*b;...
        2*b*d-2*a*c 2*c*d+2*a*b a^2-b^2-c^2+d^2];

    %Rotate data to inertial frame
    for ind=1:numData
        dout(ind,:) = (RB_I*din(ind,:)')';
    end
    
end
