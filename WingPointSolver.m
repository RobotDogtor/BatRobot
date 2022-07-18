function [wingPoints2d,wingPoints3d] = WingPointSolver(wingShape,alpha,beta)

%These points can all be solved through solving the solution to triangles,
%the connectivity matrix, and the assumption that no points can be in the
%negative x (in the body of the robot).

%There must be at least three points. wp1 is assumed to be (0,0). wp2 is
%assumed to be directly below wp1 at a distance of beta

%% Solve all in 2d
wp1 = [0; 0; 0];
wp2 = [0; -beta; 0];


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


%% Make Points in 3d


end