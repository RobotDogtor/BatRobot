%% Bat robot
clear
clc
close all

%% default dimensions
s1 = 26.5;
s2 = 7;
s3 = 9.552;
s4 = 3.2;
s5 = 9.2;
s6 = 46.234;
s7 = 3;
s8 = 7.2;
s9 = 3;
s10 = 118.775;
s11 = 36.142;

b0 = 9;
b1 = s1 + s2;
b2 = s3 + s5/2;
b3 = 10;
b4 = 3.8;
b5 = 16.4;
b6 = 4.5;
b7 = 17.4;
b8 = 37.6;
b9 = 31.12;
b10 = 27.7;
b11 = 1.545;
b12 = 23.5;
b13 = s10 + s11;
b14 = 8.66;
b15 = 6.25;

c1 = 15;
c2 = 8.802;
c3 = 6;
c4 = 15;
c5 = 10;

w1 = 25;
w2 = 25
w3 = 25;
w4 = 25;
w5 = 25;
w6 = 25;
w7 = 85.094;
w8 = 85.094;
w9 = 25;
w10 = 15;

%% Constant Spine Points
%sp0 is the origin - at the top, front, center of the spine
sp0 = [0; 0; 0];
sp1 = [-b2; -b1; -b0];
sp2 = [-b9; -s1-s8; -b10];
sp3 = 



