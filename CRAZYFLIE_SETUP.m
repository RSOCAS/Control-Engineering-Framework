%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CRAZYFLIE 2.0 Set up
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
clc;
d=39.73e-3;    %% arm length [m]
CT=3.158e-10; %% [N/rpm2]
CD=7.938e-12; %% [N.m/rpm2]
Ixx=1.657e-5;  %% moment of inertia [Kg.m2]
Iyy=1.665e-5;  %% moment of inertia [kg.m2]
Izz=2.296e-5;  %% moment of inertia [kg.m2]
m=0.027;       %% mass [Kg]

kT=0.2025;     %% adimensional
kD=0.11;       %% adimensional
fm=0.2685;     %% adimensional

g=9.81;        %% gravity [m/s2]
r=23.1348e-3;  %% rotor radius [m]



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Linear Model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
we=sqrt((m*g)/(4*CT));        %% [rpm]
PWMe=(we-4070.3)/0.2685;
OMEGA_e=(we-4070.3)/fm;

%% Model matrixes
ML1=2*we*[CT,CT,CT,CT;
    -d*CT/sqrt(2),-d*CT/sqrt(2),d*CT/sqrt(2),d*CT/sqrt(2);
    -d*CT/sqrt(2),d*CT/sqrt(2),d*CT/sqrt(2),-d*CT/sqrt(2);
    -CD,CD,-CD,CD];

ML2=[0,0;
    1,0];

ML3=[1/m;0];

ML4=[0,0;
    1,0];

ML5=[1/Izz;0];

ML6=[0,0,0,0;
    1,0,0,0;
    0,-g,0,0;
    0,0,1,0];

ML7=[1/Ixx;0;0;0];

ML8=[0,0,0,0;
    1,0,0,0;
    0,g,0,0;
    0,0,1,0];

ML9=[1/Iyy;0;0;0];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Non Linear Model
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MNL1=[CT,CT,CT,CT;
    -d*CT/sqrt(2),-d*CT/sqrt(2),d*CT/sqrt(2),d*CT/sqrt(2);
    -d*CT/sqrt(2),d*CT/sqrt(2),d*CT/sqrt(2),-d*CT/sqrt(2);
    -CD,CD,-CD,CD];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% On Board Controller
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
KPp=250;KIp=500;KDp=2.5;
KPq=250;KIq=500;KDq=2.5;
KPr=250;KIr=500;KDr=2.5;


KPphi=1.0;KIphi=0.3;KDphi=0.3;
KPtheta=1.0;KItheta=0.3;KDtheta=0.3;

% Control Mixer
MCO1=[1,-1/2,-1/2,-1;
      1,-1/2,1/2,1;
      1,1/2,1/2,-1;
      1,1/2,-1/2,1];
  
 fs_inner=50;  % 500 Hz
 fs_outer=25;  % 250 Hz
  


