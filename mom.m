%FUNCTION TO CALCULATE CALF MOMENT ABOUT ANKLE FROM CLEAT LENGTH, PEDAL
%ANGLE AND FORCE VECTOR

function [Mc,Flt] = mom(Cl,Fo,Fh,F,alpha,beta) %Cleat length, pedal angle, force angle, force

%Find the calf force
rCleat = Fh*[-sin(alpha),-cos(alpha),0]+(Cl-Fo)*[cos(alpha),-sin(alpha),0];
Force = F*[sin(beta),cos(beta),0];
Moment = cross(rCleat,Force);
Mc = abs(Moment(3));
Flt = abs(F);

end
