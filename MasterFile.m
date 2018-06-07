clc
clear all
close all

modelparameters; %initilaises parameters of the model
m=1000; % Number of crank anlges in a revolution
theta = linspace(0, 1, m); %Crank Angle
theta = theta*pi;
%alpha = -(pi/16)*cos(theta)+pi/16; %Angle of pedal- currently set to be 0.
%alpha = zeros(size(theta));
plotIt = 1; % 0: don't plot graphs, 1: plot graphs

P=200; %Power Output
C=80; %cadence, rpm
omega= C*pi/30;


if plotIt % make figure windows for graphs
    f1 = figure;
    f2 = figure;
    f3 = figure;
    f4 = figure;
else % These don't matter just matlab doesn't like null values so I set them to zero
    f1 = 0;
    f2 = 0;
    f3 = 0;
end
alpha = findAlpha(m,plotIt,f4);
N = 3;

% Cleat position optimising parameter, minimise this for the best cleat
% position
totalForce = zeros(1,N);

% for a range of cleat positions
for k = 0:1:N
    n = m;
    Cl = Fs*k/N*2/3; % Cleat positions

%Find the angular velocities
[calfExtension,V,e] = getExtension(Cl, theta, alpha, omega,UL,LL,Fs,Fh,Cr,pivot,Fo,f1,plotIt);
if e>0
    return
end
%To differentiate the forces need to be at intermediate angles
n = n-1;
stheta = (theta(1:end-1)+theta(2:end))/2;
salpha = (alpha(1:end-1)+alpha(2:end))/2;

    %Generate Forces
Fn=zeros(n, 2); %normalised force,angle
F=zeros(n,2); %absolute force/angle
Fn(:,1)=sin(stheta)+0.5; %set force at theta value
% Here I've set the angle of the force to the same as alpha assuming no
% friction on the pedal. Crap assumption but I couldn't think of a better
% way to get the angle of the pedal force without input it as another
% experiment
Fn(:,2) = salpha; %set force angle at theta value
PF = powernormalise(P, Fn(:,1), Fn(:,2), theta, n , Cr, omega);
F(:,1) = PF*Fn(:,1);
F(:,2) = Fn(:,2);

% GENERATE Calf Force
Mc = zeros(n,1);
Flt = zeros(n,1);
for i = 1:n
    [Mc(i),Flt(i)] = mom(Cl, Fo, Fh, F(i,1),alpha(i),F(i,2));
end
% Calf force velocity characteristic placeholder
x = linspace(0,5,m-1);
y = findForce(x,plotIt);

if plotIt
    [stroke(k+1),Maximum] = plotGraphs(f2,calfExtension,Mc,k,N,x,y,f3,V,Flt);
end

maxMoment = findForce(calfExtension,0);

totalForce(k+1) = sum(maxMoment'-Mc);
end


p = 0:N;
CleatPosition = p*Fs/N;
optimum = figure;
plot(CleatPosition,totalForce);
xlabel('Cleat Position - Distance from heel / m')
ylabel('Optimising criteria to be maximised');
title('Graph showing the optimum position of the cleat')
[f,l] = max(abs(totalForce));
Cl = Fs*(l-1)/N
