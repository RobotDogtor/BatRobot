% SingleOptimization

clc
clear
close all

%% Create wing
wingShape = CreateBasicWingShape();

%% Define angle and distance
alpha = 0;
beta = 30;

%% Define Wing Points
[wingPoints2d,wingPoints3d] = WingPointSolver(wingShape,alpha,15)

%% Define

plotPoints = @(setOfPoints,color) plot3(setOfPoints(1,:),setOfPoints(2,:),setOfPoints(3,:),color);
plotPointsFlip = @(setOfPoints,color) plot3(setOfPoints(1,:),-setOfPoints(2,:),setOfPoints(3,:),color);

figure('Renderer', 'painters', 'Position', [10 10 1200 700])
plotPoints(wingPoints3d,'ko')
hold on
grid on
axis equal
axis([-200 50 -200 200 -150 50])
