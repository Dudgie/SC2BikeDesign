clc
clear all
close all

v = VideoReader('benCycling.mp4');


currAxes = axes;
i = 1;
j = 1;
vidFrame = readFrame(v);
image(vidFrame, 'Parent', currAxes);
axis equal
[xA,yA] = ginput(1);
while hasFrame(v)
    x = input('Stop = 0, Continue = 1, skip = 2');
    if x == 0
        break
    elseif x == 2
        v.CurrentTime = v.CurrentTime + 0.375;
        j = j+1;
        i =1;
    else
        [x,y] = ginput(3);
        dx1 = x(2)-x(1);
        dy1 = -y(1)+y(2);
        dx2 = x(3)-xA;
        dy2 = -y(3)+yA;
        if dy2 ~=0 && dx1 ~= 0
            alpha(i,j) = atan(dy1/dx1);
            if dy2>0
                theta(i,j) = atan(dx2/dy2);
            elseif dy2<0
                theta(i,j) = atan(dx2/dy2)+pi;
            end
            pause(1/v.FrameRate);
            i = i+1;
        end
    end
    vidFrame = readFrame(v);
    image(vidFrame, 'Parent', currAxes);
    axis equal
end

