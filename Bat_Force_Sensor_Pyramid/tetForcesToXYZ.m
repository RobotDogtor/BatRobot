function [x_sum, y_sum, z_sum] = tetForcesToXYZ(side1Volt, side2Volt, ...
    side3Volt, side4Volt, caliFactor)

%written by: Trinity Blackman, Jul 2022

% Input: data from force sensors, and a single double calibration factor
%to convert between voltages and forces
% Output: x,y,z components

% What data is recieved from sensors? How to convert voltage to force?
% What is displacement angle?
% How to convert into x,y,z components per sensor?

% timetotal = input('What is the run time [s]?'); % Generates time vector for
% plotting
% time = linspace(0, timetotal, length(side1Volt));

% gravity = 9.81; % Unit: [m/s^2]
% botmass = []; % Add mass of Sally

% Convert voltage vector into N for each side 
% Side 1 corresponds to side opposing sensor only z-component
force0 = caliFactor.*side1Volt; 
force1 = caliFactor.*side2Volt;
force2 = caliFactor.*side3Volt;
force3 = caliFactor.*side4Volt;

% Define vectors - (0.1.2.3.4 = A.B.C.D.E where E is center pt)
strlength = 0.7*((3^(1/2))/3);
v0 = [0, 0, strlength];
v1 = [0, strlength*cosd(19.5), -strlength*sind(19.5)];
v2 = [strlength*cosd(19.5)*sind(60), -strlength*cosd(19.5)*cosd(60), ...
    -strlength*sind(19.5)];
v3 = [-strlength*cosd(19.5)*sind(60), -strlength*cosd(19.5)*cosd(60), ...
    -strlength*sind(19.5)];

% Define unit vectors
u0 = v0./norm(v0);
u1 = v1./norm(v1);
u2 = v2./norm(v2);
u3 = v3./norm(v3);

% Break down force magnitudes into x,y,z components
f0_z = u0(3).*force0; % Force 0 only acts in z 

f1_y = u1(2).*force1; % Force 1 only acts in y,z 
f1_z = u1(3).*force1;

f2_x = u2(1).*force2;
f2_y = u2(2).*force2;
f2_z = u2(3).*force2;

f3_x = u3(1).*force3;
f3_y = u3(2).*force3;
f3_z = u3(3).*force3;

x_sum = f2_x + f3_x;
y_sum = f1_y + f2_y + f3_y;
z_sum = f0_z + f1_z + f2_z + f3_z; % This includes contribution from gravity

% lift? = z_sum - (gravity*botmass);

% Plots data over time interval
% figure
% hold on
% plot(time, x_sum);
% title('Forces in x');
% xlabel('Time [s]');
% ylabel('Force [N]');

% plot(time, y_sum);
% title('Forces in y');
% xlabel('Time [s]');
% ylabel('Force [N]');

% plot(time, z_sum);
% title('Forces in z');
% xlabel('Time [s]');
% ylabel('Force [N]');
% hold off

end