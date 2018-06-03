clc
clear all
close all

% Get file to read
[vfile,vpath] = uigetfile('*.mp4','Select Video to Analyse');
videoFile = fullfile(vpath, vfile);
v = VideoReader(videoFile);

currAxes = axes;
i = 1;
vidFrame = readFrame(v);
image(vidFrame, 'Parent', currAxes);
axis equal
[xA,yA] = ginput(1);
while hasFrame(v)
    x = int64(input('Stop = 0, Continue = number of frames, skip = anything else'));
    if x == 0
        break
    elseif x>0
        for k = 1:x
        
            [x,y] = ginput(3);
            dx1 = x(2)-x(1);
            dy1 = -y(1)+y(2);
            dx2 = x(3)-xA;
            dy2 = -y(3)+yA;
            if dy2 ~=0 && dx1 ~= 0
                alpha(i) = atan(dy1/dx1);
                if dy2>0
                    theta(i) = atan(dx2/dy2);
                elseif dy2<0
                    theta(i) = atan(dx2/dy2)+pi;
                end
                pause(1/v.FrameRate);
                i = i+1;
            end
            vidFrame = readFrame(v);
            image(vidFrame, 'Parent', currAxes);
            axis equal
        end
    else
        v.CurrentTime = v.CurrentTime + 0.375;
        vidFrame = readFrame(v);
        image(vidFrame, 'Parent', currAxes);
        axis equal
    end
    
end

% Set file to write
[dfile,dpath] = uiputfile('*.dat');
dataFile = fullfile(dpath,dfile);
csvwrite(dataFile,[theta;alpha])
