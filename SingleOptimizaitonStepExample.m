% SingleOptimization

clc
clear
close all

addpath ./OriginalPlotting
addpath ./Library

%% Create wing
wingShape = CreateBasicWingShape();

%% Define angle and distance
alpha = 0.1;
beta = 49.9;

%% Define Wing Points
[wingPoints2d,wingPoints3d] = WingPointSolver(wingShape,alpha,beta)

%% Define

plotPoints = @(setOfPoints,color) plot3(setOfPoints(1,:),setOfPoints(2,:),setOfPoints(3,:),color);
plotPointsFlip = @(setOfPoints,color) plot3(setOfPoints(1,:),-setOfPoints(2,:),setOfPoints(3,:),color);

figure('Renderer', 'painters', 'Position', [10 10 1200 700])
hold on
plotPoints(wingPoints3d,'ko')
for i = 1:length(wingShape.rigidBodies(:,1))
    plotPoints([wingPoints3d(:,wingShape.rigidBodies(i,1)) wingPoints3d(:,wingShape.rigidBodies(i,2))],'b-')
end
grid on
axis equal
axis([-200 50 -200 200 -150 50])
