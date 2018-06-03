clc
clear all
close all

% Number of locations
N = 11;

% Get file to read
[ifile,ipath] = uigetfile({'*.png','*.jpg'},'Select Image to Analyse');
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

scatter(r,xReal);
hold on
plot([0,0],[xReal(1),xReal(end)]);
xlabel('Error in the measurement')
ylabel('location')
title('Graph of the error in the distance measurement')

sigma = (sum(r.^2)/N)^0.5;
dE = norminv([0.025 0.975],0,sigma);
disp(dE);





