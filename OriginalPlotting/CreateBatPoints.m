function BatPoints = CreateBatPoints(theta)
%This function creates the points and lines that define the bat robot
%Input is the motor angle/process variable theta

%% default dimensions
s1 = 26.5;
s2 = 10.75;
s3 = 9.552;
s4 = 3.2;
s5 = 9.2;
s6 = 46.234;
s7 = 3;
s8 = 7.2;
s9 = 3;
s10 = 118.775;
s11 = 36.142;

b0 = 10;
b1 = s1/2 + s2;
b2 = s3 + s5/2;
b3 = 10;
b4 = 3.8;
b5 = 16.4;
b6 = 4.5;
b7 = 17.4;
b8 = 37.6;
b9 = 30;
b10 = 27.7;
b11 = 1.545;
b12 = 23.5;
b13 = s10 + s11;
b14 = 8.66;
b15 = 6.25;

c1 = 15;
c2 = 8.802;
c3 = 6;
c4 = 15;
c5 = 10;
c0 = sqrt(c2^2 + c3^2);

w1 = 25;
w2 = 25;
w3 = 25;
w4 = 25;
w5 = 25;
w6 = 25;
w7 = 85.094;
w8 = 85.094;
w9 = 25;
w10 = 15;

%% Constant Spine Points
%sp0 is the origin - at the top, front, center of the spine
sp0 = [0; 0; 0];
sp1 = [-b2; -b1; -b0];
sp2 = [-b9; -(s1/2)-s8; -b10];
sp3 = [-b11; -(s1/2); -b12];
sp4 = [-b13; -b14; -b15];

BatPoints.sp = [sp1,sp2,sp3,sp4];

%% body Points
bp7 = sp3 + [b6*sin(theta); -s8; b6*cos(theta)];
bp8 = bp7 + [0; -s9; 0];

%bp9 is a certain distance from sp2 and bp5
[p3x,p3y] = ThirdPointSolver_Upper(sp2(1),sp2(3),bp7(1),bp7(3),b3,b12);
bp9 = [p3x; sp2(2); p3y];
%bp6 is in the direction sp2 to bp9
dir = (bp9 - sp2)/b3;
bp6 = sp2 + dir*(b3+b4);

%bp2 is a certain distance from sp1 and bp8 in 3D, x is fixed however
%center 1 is the center of the first circle based around sp1
center1_yz = [sp1(2); sp1(3)];
center1_x = sp1(1) + c3;
%center2 is the center based around bp8, projected to center1_x
center2_x_diff = center1_x - bp8(1);
%distance to bp2 is now b7 minus the distance for x too
b7_altered = sqrt(b7^2 - center2_x_diff^2);
[p3x,p3y] = ThirdPointSolver_Outer(sp1(2),sp1(3),bp7(2),bp7(3),c2,b7_altered);
bp2 = [center1_x; p3x; p3y];
cp0 = bp2 + [-c3; 0; 0];

%beta (wing angle) can now be defined as the angle that bp2 makes with sp1
hypot = bp2(2:3) - sp1(2:3);
beta = atan2(hypot(2),-hypot(1));

%bp1 is then in the direction of hypot from sp1
hypot_hat = hypot/norm(hypot);
bp1 = sp1 + [0; c1*hypot_hat];

%bp3 is sp1 plus the variable v1 in x
%yz position of bp5 is 
bp5yz = sp1(2:3) + [-c5*sin(beta); -c5*cos(beta)];
%bp5 is a certain distance from bp6. Distance in x can be found
bp5_to_bp6_xDist = sqrt( b5^2 - (bp5yz(1)-bp6(2))^2 - (bp5yz(2)-bp6(3))^2 );
bp5 = [bp6(1)-bp5_to_bp6_xDist; bp5yz];
bp3 = [bp5(1); sp1(2:3)];
bp4 = [bp5(1); sp1(2)-c4*cos(beta); sp1(3)+c4*sin(beta)]; 
v1 = abs(bp3(1)-sp1(1));

BatPoints.bp = [bp1,bp2,bp3,bp4,bp5,bp6,bp7,bp8];

%% 2D wing points (in x and y as if beta = 0)
wp1 = [0; 0; 0];
wp2 = [-v1; 0; 0];
[p3x,p3y] = ThirdPointSolver_Outer(wp1(1),wp1(2),wp2(1),wp2(2),w1,w2);
wp3 = [p3x; p3y; 0];
dir = (wp3-wp1)/w1;
wp5 = wp3 + dir*w4;
wp6 = wp5 + dir*w6;
[p3x,p3y] = ThirdPointSolver_Outer(wp5(1),wp5(2),wp2(1),wp2(2),w5,w3);
wp4 = [p3x; p3y; 0];
dir = (wp5-wp4)/w5;
wp7 = wp5 + dir*w7;
[p3x,p3y] = ThirdPointSolver_Lower(wp7(1),wp7(2),wp6(1),wp6(2),w9,w8);
wp8 = [p3x; p3y; 0];
dir = (wp8-wp7)/w9;
wp9 = wp8 + dir*w10;

wp2d = [wp1,wp2,wp3,wp4,wp5,wp6,wp7,wp8,wp9];

rotateWingPoints = @(wPts,angle,basePoint) [wPts(1,:); wPts(2,:)*cos(angle); -wPts(2,:)*sin(angle)] + basePoint;
BatPoints.wp = rotateWingPoints(wp2d,beta,bp1);

%% collect and plot all points

BatPoints.linesK1 = [sp3 bp7 bp8 bp2];
BatPoints.linesK2 = [bp7 bp9 sp2 bp6 bp5];
BatPoints.linesB1 = [bp5 bp3 bp4];
BatPoints.linesB2 = [bp2 cp0 bp1 sp1];
linesR12d = [wp3 wp2 wp4 wp7 wp9 wp8 wp6 wp1];
BatPoints.linesR1 = rotateWingPoints(linesR12d,beta,bp1);

    
