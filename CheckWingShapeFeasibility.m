function wingShape = CheckWingShapeFeasibility(wingShape)
%Checks if the shape given is feasible. wp1 and wp2 connected. Make sure
%that there are enough connections and none too long or small. No locking.

%Check that the order to solve the points in is feasible

wingPointOrder = zeros(1,wingShape.N);
wingPointOrder(1) = 1;
wingPointOrder(2) = 2;
totalPriorConnections = sum(wingShape.ConnectivityMatrix);

check = 0;

% check for non joint overlap
end