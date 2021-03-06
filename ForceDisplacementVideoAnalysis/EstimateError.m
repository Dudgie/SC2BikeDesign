clc
clear all
close all

% Number of locations
N = 9;

% Get file to read
[ifile,ipath] = uigetfile;
imageFile = fullfile(ipath, ifile); 
A = imread(imageFile);

% Put on the axes
currAxes = axes;
image(A, 'Parent', currAxes);

% get scale and bounds
disp('Select bounds and enter distance');
[xB,yB] = ginput(2);
D = input('Distance between points : ');

Scale = D/(xB(2)-xB(1));


% get points
disp('select the points in assending order');
[x,y] = ginput(N);

xReal = linspace(0,D,N);
xMeasured = (x'-xB(1))*Scale;

r = xMeasured-xReal;

f1 = figure;
scatter(r,xReal);
hold on
plot([0,0],[xReal(1),xReal(end)]);
xlabel('Error in the measurement')
ylabel('location')
title('Graph of the error in the distance measurement')


sigma = (sum(r.^2)/N)^0.5;
average = (max(r)+min(r))/2;
dE = norminv([0.025 0.975],average,sigma);
disp(dE);

p = polyfit(xMeasured,r,2);
Cf = polyval(p,xMeasured);
xMeasuredCor = xMeasured - Cf;
rCor = xMeasuredCor - xReal;
sigmaCor = (sum(rCor.^2)/N)^0.5;
averageCor = (max(rCor)+min(rCor))/2;
dECor = norminv([0.025 0.975],averageCor,sigmaCor);
disp(dECor);

f2 = figure;
scatter(rCor,xReal);
hold on
plot([0,0],[xReal(1),xReal(end)]);
xlabel('Error in the measurement')
ylabel('location')
title('Graph of the error in the distance measurement correcting using a parabola')

xRealTan = xReal-150;
xM = (xB(2)+xB(1))/2;
xShift = x'-xM;


w = 600;
thetaMax = atan(D/(2*w));
thetah = thetaMax*xShift/(xB(2)-xM);
h = w*tan(thetah);

rTan = h-xRealTan;
sigmaTan = (sum(rTan.^2)/N)^0.5;
averageTan = (max(rTan)+min(rTan))/2;
dETan = norminv([0.025 0.975],averageTan,sigmaTan);
disp(dETan);

f3 = figure;
scatter(rTan,xRealTan);
hold on
plot([0,0],[xRealTan(1),xRealTan(end)]);
xlabel('Error in the measurement')
ylabel('location')
title('Graph of the error in the distance measurement correcting for curvature')


pTan = polyfit(h,rTan,2);
CfTan = polyval(pTan,h);
hCor = h - CfTan;
rCorTan = hCor - xRealTan;
sigmaCorTan = (sum(rCorTan.^2)/N)^0.5;
averageCorTan = (max(rCorTan)+min(rCorTan))/2;
dECorTan = norminv([0.025 0.975],averageCorTan,sigmaCorTan);
disp(dECorTan);


f4 = figure;
scatter(rCorTan,xRealTan);
hold on
plot([0,0],[xRealTan(1),xRealTan(end)]);
xlabel('Error in the measurement')
ylabel('location')
title('Graph of the error in the distance measurement using both methods')

