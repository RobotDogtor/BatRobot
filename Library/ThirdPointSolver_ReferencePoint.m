function [p3x,p3y] = ThirdPointSolver_ReferencePoint(p1x,p1y,p2x,p2y,d13,d23,pRx,pRy,dR)
%Returns the solution to the Third Point Solver that is closest to the
%desired distance from a third point

    [p3x_1,p3y_1,p3x_2,p3y_2] = ThirdPointSolver(p1x,p1y,p2x,p2y,d13,d23);
    
    p3_1 = [p3x_1;p3y_1];
    p3_2 = [p3x_2;p3y_2];
    pR = [pRx;pRy];

    if (norm(p3_1-pR)-dR)<(norm(p3_1-pR)-dR)
        p3x = p3x_1;
        p3y = p3y_1;
    else
        p3x = p3x_2;
        p3y = p3y_2;
    end
end

