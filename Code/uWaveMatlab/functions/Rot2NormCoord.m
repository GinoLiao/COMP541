function dout = Rot2NormCoord(azimuth,pitch,roll,din)
    [numData,~] = size(din);
    
    dout=zeros(size(din));
    
    %Get rotation matrix (Source:
    %http://www.chrobotics.com/library/understanding-euler-angles)
    RI_v1=[cosd(-azimuth) sind(-azimuth) 0;...
        -sind(-azimuth) cosd(-azimuth) 0;...
        0 0 1]
    Rv1_v2=[cosd(-roll) 0 -sind(-roll);...
        0 1 0;...
        sind(-roll) 0 cosd(-roll)]
    Rv2_B=[1 0 0;...
        0 cosd(-pitch) sind(-pitch);...
        0 -sind(-pitch) cosd(-pitch)]
    RB_I=RI_v1*Rv1_v2*Rv2_B
    
    %Rotate data to inertial frame
    for ind=1:numData
        dout(ind,:) = (RB_I*din(ind,:)')';
    end
    
    
%     for ind=1:numData
%         temp = [din(ind,:)'; 1]
%         %Undo azimuth angle
%         temp = [cosd(-azimuth) -sind(-azimuth) 0 0;...
%             sind(-azimuth) cosd(-azimuth) 0 0;...
%             0 0 1 0;...
%             0 0 0 1]*(temp)
%         %Undo pitch
%         temp = [1 0 0 0;...
%             0 cosd(-pitch) -sind(-pitch) 0 ;...
%             0 sind(-pitch) cosd(-pitch) 0 ;...
%             0 0 0 1]*(temp)
%         %Undo roll
%         temp = [cosd(-roll) 0 sind(-roll) 0;...
%             0 1 0 0;...
%             -sind(-roll) 0 cosd(-roll) 0;...
%             0 0 0 1]*(temp)
%         
%         dout(ind,:) = temp(1:3)';
%     end
end