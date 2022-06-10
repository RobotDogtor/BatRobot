function [p3x,p3y] = ThirdPointSolver_Outer(p1x,p1y,p2x,p2y,d13,d23)
%Returns only the outer solution (in x) of the Third Point Solver

%to avoid NAN switch x and y
if (p1y == p2y)
    switched = true;
    tempp1y = p1y;
    tempp2y = p2y;
    p1y = p1x;
    p2y = p2x;
    p1x = tempp1y;
    p2x = tempp2y;
else
    switched = false;
end

[p3x_1,p3y_1,p3x_2,p3y_2] = ThirdPointSolver(p1x,p1y,p2x,p2y,d13,d23);

if switched
    tempp3y1 = p3y_1;
    tempp3y2 = p3y_2;
    p3y_1 = p3x_1;
    p3y_2 = p3x_2;
    p3x_1 = tempp3y1;
    p3x_2 = tempp3y2;
end

if (abs(p3x_1)>abs(p3x_2))
    p3x = p3x_1;
    p3y = p3y_1;
else
    p3x = p3x_2;
    p3y = p3y_2;
end
end

