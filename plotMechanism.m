function plotMechanism(alpha,PivotPosition, ankle, heel, knee, pedal, CleatPosition,FootSize,ULConnection,f1)

%Plot 5 leg positions
figure(f1);
clf
n = floor(length(alpha)/5);
N = 1:n:length(alpha);

toe = pedal + CleatPosition*[-cos(alpha);sin(alpha)] - FootSize*[-cos(alpha);sin(alpha)];
PivotVector = PivotPosition*ones(size(alpha));
UL = line([zeros(5);knee(1,N)],[zeros(5);knee(2,N)],'Color','red');
LL = line([knee(1,N);ankle(1,N)],[knee(2,N);ankle(2,N)],'Color','green');
F = line([ankle(1,N);toe(1,N)],[ankle(2,N);toe(2,N)],'Color','blue');
line([heel(1,N);toe(1,N)],[heel(2,N);toe(2,N)],'Color','blue');
line([ankle(1,N);heel(1,N)],[ankle(2,N);heel(2,N)],'Color','blue');
Cr = line([pedal(1,N);PivotVector(1,N)],[pedal(2,N);PivotVector(2,N)],'Color','black');
Calf = line([heel(1,N);ULConnection(1,N)],[heel(2,N);ULConnection(2,N)],'Color','yellow');
xlabel('x');
ylabel('y');
legend([UL(1),LL(1),F(1),Cr(1),Calf(1)],{'Upper Leg','Lower Leg','Foot','Crank','Calf'});
axis equal
end