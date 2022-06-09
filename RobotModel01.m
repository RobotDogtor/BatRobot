%% Bat robot
clear
clc
close all

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

%% Process Variable
theta = 0;

%% body Points
bp7 = sp3 + [b6*sin(theta); -s8; b6*cos(theta)];
bp8 = bp7 + [0; s9; 0];

%bp5 is a certain distance from sp2 and bp5
[p3x,p3y] = ThirdPointSolver_Upper(sp2(1),sp2(3),bp7(1),bp7(3),b3,b12);
bp5 = [p3x; sp2(2); p3y];

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

%beta (wing angle) can now be defined as the angle that bp2 makes with sp1
hypot = bp2(2:3) - sp1(2:3);
beta = atan2(hypot(2),-hypot(1));

%bp1 is then in the direction of hypot from sp1
hypot_hat = hypot/norm(hypot);
bp1 = sp1 + [0; c1*hypot_hat];

%bp3 is sp1 plus the variable v1 in x
%yz position of bp5 is 
bp5yz = 

%% collect and plot all points



