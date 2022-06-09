function [p3x,p3y] = ThirdPointSolver_Upper(p1x,p1y,p2x,p2y,d13,d23)
%Returns only the upper solution (in y) of the Third Point Solver

[p3x_1,p3y_1,p3x_2,p3y_2] = ThirdPointSolver(p1x,p1y,p2x,p2y,d13,d23);

if (p3y_1>p3y_2)
    p3x = p3x_1;
    p3y = p3y_1;
else
    p3x = p3x_2;
    p3y = p3y_2;
end
end

