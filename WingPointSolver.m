function [wingPoints2d,wingPoints3d] = WingPointSolver(wingShape,alpha,beta)

%These points can all be solved through solving the solution to triangles,
%the connectivity matrix, and the assumption that no points can be in the
%negative x (in the body of the robot).

%There must be at least three points. wp1 is assumed to be (0,0). wp2 is
%assumed to be directly below wp1 at a distance of beta

%% Solve all in 2d
wp1 = [0; 0; 0];
wp2 = [-beta; 0; 0];
[p3x,p3y] = ThirdPointSolver_Outer(wp1(1),wp1(2),wp2(1),wp2(2),25,25);
wp3 = [p3x; p3y; 0];

% % Check all prior connections
% toFind = 3:wingShape.N
% totalPriorConnections = sum(wingShape.ConnectivityMatrix);
% foundPoints = [1 2];
% skippedPoints = [];
% % First find all well defined points - one viable solution or 3 prior
% % points
% for i = 3:wingShape.N


    

[p3x,p3y] = ThirdPointSolver_Outer(wp1(1),wp1(2),wp2(1),wp2(2),25,25);
wp3 = [p3x; p3y; 0];
dir = (wp3-wp1)/25;
wp5 = wp3 + dir*25;
wp6 = wp5 + dir*25;
[p3x,p3y] = ThirdPointSolver_Outer(wp5(1),wp5(2),wp2(1),wp2(2),25,25);
wp4 = [p3x; p3y; 0];
dir = (wp5-wp4)/25;
wp7 = wp5 + dir*85;
[p3x,p3y] = ThirdPointSolver_Lower(wp7(1),wp7(2),wp6(1),wp6(2),25,85);
wp8 = [p3x; p3y; 0];
dir = (wp8-wp7)/25;
wp9 = wp8 + dir*15;

wingPoints2d = [wp1,wp2,wp3,wp4,wp5,wp6,wp7,wp8,wp9];

%% Make Points in 3d
rotateWingPoints = @(wPts,angle,basePoint) [wPts(1,:); wPts(2,:)*cos(angle); -wPts(2,:)*sin(angle)] + basePoint;
wingPoints3d = rotateWingPoints(wingPoints2d,alpha,[0;0;0]);



end