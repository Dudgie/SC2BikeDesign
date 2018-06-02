%Function to generate the angular velocites of the various parts of
%the leg from the angular velocity of the crank
function [calfExtension,V,e] = getExtension(CleatPosition, theta, alpha, omega,UpperLeg,LowerLeg,FootSize,FootHeight,CrankLength,PivotPosition,FootOffset,f1,plotIt)
    [psi,ankle,e] = getAngles(CleatPosition, theta, alpha,UpperLeg,LowerLeg,FootSize,FootHeight,CrankLength,PivotPosition,FootOffset,f1,plotIt);
    if e>0
        psi =0;
        calfExtension = 0;
        V =0;
        return
    end
    dt = findDT(theta, omega);
    
    %Velocity
    psidot = (psi(1:end-1)-psi(2:end))./dt;
    alphadot = (alpha(1:end-1)-alpha(2:end))./dt;
    calfExtension = abs(psidot-alphadot);
    VX = (ankle(1,1:end-1)-ankle(1,2:end))./dt;
    VY = (ankle(2,1:end-1)-ankle(2,2:end))./dt;
    spsi = (psi(1:end-1)+psi(2:end))/2;
    
    V = [VX.*sin(spsi)+VY.*cos(spsi);VX.*cos(spsi)-VY.*sin(spsi)];
end