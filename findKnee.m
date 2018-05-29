function knee = findKnee(ankle,UpperLeg,LowerLeg)

%Find the values of a, b and c in ax^2 + bx + c = 0 to find
%the position of the knee
%End up with a vector full of constant values to solve
%quadratic equations
a = 4*((ankle(1,:).^2+ankle(2,:).^2));
b = -4*ankle(1,:).*(UpperLeg^2-LowerLeg^2+(ankle(1,:).^2+ankle(2,:).^2));
c = (UpperLeg^2-LowerLeg^2+(ankle(1,:).^2+ankle(2,:).^2)).^2-4*UpperLeg^2*ankle(2,:).^2;

%xr is a vector of roots to the quadratic equations found
%above
xr = zeros(2,length(ankle));
for i = 1:length(ankle)
    xr(:,i) = roots([a(i) b(i) c(i)]);
end

%We now have 2 values of x, need to decide which one to
%use. The leg cannot bend inside out so the value of x
%furthest in the positive direction will be the x position
%of the knee
s = xr(1,:)>=xr(2,:);
t = xr(1,:)<xr(2,:);
x = xr(1,:).*s+xr(2,:).*t;

%Find the corresponding y positions
y = ankle(2,:)+sqrt(LowerLeg^2-(x-ankle(1,:)).^2);

%Array full of vectors indicating the position of the knee
%around one pedal cycle
knee = [x;y];

end