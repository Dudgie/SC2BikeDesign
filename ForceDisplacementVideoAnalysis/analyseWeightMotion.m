clc
clear all
close all

% Get file to read
[vfile,vpath] = uigetfile('*.mp4','Select Video to Analyse');
videoFile = fullfile(vpath, vfile);
v = VideoReader(videoFile);

currAxes = axes;
i = 1;
p = [0.0002 -0.0531 -0.8536];

vidFrame = readFrame(v);
image(vidFrame, 'Parent', currAxes);
axis equal
[xA,yA] = ginput(3);
scale = 1/(yA(1)-yA(2));
start = yA(3);
while hasFrame(v)
    x = int64(input('Stop = 0, Continue = number of frames, skip = anything else'));
    if x == 0
        break
    elseif x>0
        for k = 1:x
        
            [x,y] = ginput(1);
            z(i) = (y-start)*scale;
            t(i) = i/v.FrameRate;
            
            Cf = polyval(p,z);
            z = z - Cf;
            
            i = i +1;
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
csvwrite(dataFile,[t;z])
