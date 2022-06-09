function [p3x_1,p3y_1,p3x_2,p3y_2] = ThirdPointSolver(p1x,p1y,p2x,p2y,d13,d23)
%THIRDPOINTSOLVER this function takes in two, 2D points and a distance from
%each of these two points and then solves for a third point that is that
%distance from each point. This solver provides two solutions.
    alpha = d13^2 - d23^2 - (p1x^2-p2x^2) - (p1y^2-p2y^2);
    m = -(p1x-p2x)/(p1y-p2y);
    b = -0.5*alpha/(p1y-p2y);
    k = b-p1y;
    
    c1 = 1+m^2;
    c2 = 2*m*k - 2*p1x;
    c3 = p1x^2 + k^2 - d13^2;
    
    p3x_1 = (-c2 + sqrt(c2^2 - 4*c1*c3))/(2*c1);
    p3x_2 = (-c2 - sqrt(c2^2 - 4*c1*c3))/(2*c1);
    
    p3y_1 = m*p3x_1 + b;
    p3y_2 = m*p3x_2 + b;
    
    %% Should throw error if imaginary: circles do not intersect
    
end

