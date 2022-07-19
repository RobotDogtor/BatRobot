function wingShape = CreateBasicWingShape()
%CREATEWINGSHAPE Ths function creates a WingShape that is usable by the bat
%robot Optimization code.
%
%A WingShape consists of 
% N - a number of wing Points N
% M - number of connections 
% ConnectivityMatrix - an NxN upper-diagonal connectivity matrix (with zero
%                      diagonal) with  zero or 1 in the spot if the two 
%                      points are connected. Connectivity is 1 if two
%                      points share a rigid body. If a single body has
%                      many points, then each point is connected to each
%                      other.
% ConnectionLengths - 1xM array of lenghts of connections between points.
% ConnectionLengthMatrix - NxN connectivity matrix with entries equal to
%                          connection length
% FullConnectivityMatrix - NxN connectivity matrix, full symmetric

%Millimeters!

%Note: the top left 2x2 corner of the connectivity matrix should always be
%      zero. It is assumed that point wp1 is the origin of the wing, and point
%      wp2 is directly below wp1 at a distance beta, which is the shoulder
%      distance, one of the two independent variables.

    wingShape.N = 9;
    %                               1 2 3 4 5 6 7 8 9
    wingShape.ConnectivityMatrix = [0 0 1 0 1 1 0 0 0 ;%1
                                    0 0 1 1 0 0 0 0 0 ;%2
                                    0 0 0 0 1 1 0 0 0 ;%3
                                    0 0 0 0 1 0 1 0 0 ;%4
                                    0 0 0 0 0 1 1 0 0 ;%5
                                    0 0 0 0 0 0 0 1 0 ;%6
                                    0 0 0 0 0 0 0 1 1 ;%7
                                    0 0 0 0 0 0 0 0 1 ;%8
                                    0 0 0 0 0 0 0 0 0];%9
    wingShape.M = sum(sum(wingShape.ConnectivityMatrix));
    wingShape.ConnectionLengths = [25; 50; 75; %1
                                   25; 25; %2
                                   25; 50; %3
                                   25; 110; %4
                                   25; 85; %5
                                   85; %6
                                   25; 40; %7
                                   15; %8
                                   ]';
    wingShape.RigidBodies = {[]}

    %% Calculations for Representations
    wingShape.ConnectionLengthMatrix = zeros(wingShape.N,wingShape.N);
    wingShape.AllConnectionLines = zeros(wingShape.M,2);
    k = 0;
    for j = 1:wingShape.N
        for i = 1:wingShape.N
            if wingShape.ConnectivityMatrix(j,i) == 1
                k = k + 1;
                wingShape.ConnectionLengthMatrix(j,i) = wingShape.ConnectionLengths(k);
                wingShape.AllConnectionLines(k,:) = [j,i];
            end
        end
    end
    wingShape.FullConnectivityMatrix = wingShape.ConnectivityMatrix + wingShape.ConnectivityMatrix';

    % find rigid bodies: find fully connected groups
    unplacedLines = wingShape.AllConnectionLines;
    while length(unplacedLines(:,1))>0
        connectedLines = find(unplacedLines(:,1) == unplacedLines(1,1));
        iToRemove = [1];
        connectedTo = unplacedLines(connectedLines,2); %find points the first is connected to
        for i = 1:length(connectedTo)
            connectedLines_i = find(unplacedLines(:,1) == connectedTo(i)); %lines connected to ith connection from i
            
            iToRemove = [iToRemove connectedLines(i)]; %remove ith connection
            if sum(unplacedLines(connectedLines_i,2)==connectedTo(i+1))>0
                %The one to remove is the i of the line from point i to i+1 along original body
                iToRemove = [iToRemove connectedLines_i(unplacedLines(connectedLines_i,2)==connectedTo(i+1))];
            end
        end
    end
end

