%FUNCTION TO GENERATE SCALING FACTOR FOR DESIRED POWER FROM NORMALISED
%FORCE PROFILE

%Only tangential pedal force contributes to output power. 

function[NF] = powernormalise (P, F, beta, theta, n, Cr, omega) %P = Desired Power output, N is number of discretisation, F is force at a discretisation, beta is angle at discretisation.

dt = findDT(theta,omega);

Energy=0;
for i =1:n
    Ftheta(i) = F(i)*sin(theta(i)-beta(i));
    Energy = Energy + Ftheta(i) * Cr * omega * dt(i);
end
power = Energy*omega/(2*pi);
NF=P/power; 

end