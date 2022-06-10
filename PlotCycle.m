clear 
clc
close all

plotPoints = @(setOfPoints,color) plot3(setOfPoints(1,:),setOfPoints(2,:),setOfPoints(3,:),color);
plotPointsFlip = @(setOfPoints,color) plot3(setOfPoints(1,:),-setOfPoints(2,:),setOfPoints(3,:),color);

%%
theta = 0;
BP = CreateBatPoints(theta);

s1 = 26.5;
s10 = 118.775;

%% Plot Bat Points

figure('Renderer', 'painters', 'Position', [10 10 1200 700])
thetaVec = 0:0.1:8*pi;

for i = 1:length(thetaVec)
    theta = thetaVec(i);
    BP = CreateBatPoints(theta);
    
    plotPoints(BP.sp,'ko')
    hold on
    grid on
    axis equal
    axis([-200 50 -200 200 -150 50])
    plotPoints(BP.bp,'bo')
    plotPoints(BP.wp,'rx')
    plotPoints(BP.linesK1,'k')
    plotPoints(BP.linesK2,'k')
    plotPoints(BP.linesB1,'b')
    plotPoints(BP.linesB2,'b')
    plotPoints(BP.linesR1,'r')
    plotcube([s10 s1 15],[-s10 -s1/2 -15],0.8,[0 1 0.2])
    plotPointsFlip(BP.sp,'ko')
    plotPointsFlip(BP.bp,'bo')
    plotPointsFlip(BP.wp,'rx')
    plotPointsFlip(BP.linesK1,'k')
    plotPointsFlip(BP.linesK2,'k')
    plotPointsFlip(BP.linesB1,'b')
    plotPointsFlip(BP.linesB2,'b')
    plotPointsFlip(BP.linesR1,'r')
    plotcube([s1*1.5 s1 s1/1.5],[-s1*1.5 -s1/2 -15-s1/1.5],.8,[0 1 0.2]);
    
    pause(0.001)
    hold off
end

