clc
clear all
close all

modelparameters; %initilaises parameters of the model
m=1000;
theta = linspace(0, 1, m); %Crank Angle
theta = theta*pi;
alpha = -(pi/16)*cos(theta)+pi/16; %Angle of pedal- currently set to be 0.
%alpha = zeros(size(theta));
P=200; %Power Output
C=80; %cadence, rpm
omega= C*pi/30;
f1 = figure;
f2 = figure;
f3 = figure;
N = 5;

totalForce = zeros(1,N);

for k = 0:1:N
    n = m;
    Cl = 0.12*k/N;

%Find the angular velocities
[psi,calfExtension,V,e] = getExtension(Cl, theta, alpha, omega,UL,LL,Fs,Fh,Cr,pivot,Fo,f1);
if e>0
    return
end
%To differentiate the forces need to be at intermediate angles
n = n-1;
stheta = (theta(1:end-1)+theta(2:end))/2;
spsi = (psi(1:end-1)+psi(2:end))/2;


    %Generate Forces
Fn=zeros(n, 2); %normalised force,angle
F=zeros(n,2); %absolute force/angle
Fn(:,1)=sin(stheta)+0.5; %set force at theta value
Fn(:,2)=0; %set force angle at theta value
PF = powernormalise(P, Fn(:,1), Fn(:,2), theta, n , Cr, omega);
F(:,1) = PF*Fn(:,1);
F(:,2) = Fn(:,2);

% GENERATE Calf Force
Mc = zeros(n,1);
Flt = zeros(n,1);
Fln = zeros(n,1);
for i = 1:n
    [Mc(i),Flt(i)] = mom(Cl, Fo, Fh, F(i,1),alpha(i),F(i,2));
end
x = 0:0.1:10;
y = 100-10*x;
plotGraphs(f2,calfExtension,Mc,k,N,x,y,f3,V,Flt)
totalForce(k+1) = sum(Mc);
end
[f,i] = min(totalForce);
Cl = 0.12*(i-1)/N
