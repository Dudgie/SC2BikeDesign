%Function calculating the positions and angles of the leg for
%various values of theta (crank angle)
%Theta and alpha need to be the same length
%When plot = 1 a graph is plotted of the geometry
%Cleat position is the distance from the ankle to the cleat
function [psi,ankle,e] = getAngles(CleatPosition, theta, alpha,UpperLeg,LowerLeg,FootSize,FootHeight,CrankLength,PivotPosition,FootOffset,f1,plotIt)
    %Do the distances add up?
    %Find an array of vectors indicating the position of the
    %pedal positions around a pedal cycle
    pedal = PivotPosition*ones(size(theta))+[CrankLength*sin(theta);CrankLength*cos(theta)];
    %Find an array of vectors indicating the position of the
    %ankle around one pedal cycle
    heel = pedal + CleatPosition*[-cos(alpha);sin(alpha)];
    ankle = heel + FootHeight*[sin(alpha);cos(alpha)] + FootOffset*[cos(alpha);-sin(alpha)];
    
    e = 0;
    for i = 1:length(theta)
        if norm(ankle(:,i))>UpperLeg+LowerLeg
            disp('pivot too far away');
            e = e+1;
            phi = 0;
            psi = 0;
            return
        end
    end
    
    if e>0
        disp('pivot too far away');
        phi = [];
        psi = [];
    else
        
        knee = findKnee(ankle,UpperLeg,LowerLeg);
        
        % phi is a vector full of angles the knee makes to the
        % horizontal during one revolution of the crank
        phi = atan(knee(2,:)./knee(1,:));
        %psi is a vector full of angles the shin makes with the
        %vertical direction.
        psi = atan((ankle(1,:)-knee(1,:))./(ankle(2,:)-knee(2,:)));
        
        if plotIt
            plotMechanism(alpha,PivotPosition, ankle, heel, knee, pedal, CleatPosition,FootSize,f1);
        end
    end
end