%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% General Calibration Process for main variables z, roll, pitch and yaw.
% By Rafael Socas, Raquel Dormido, Maria Guinaldo and Sebastian Dormido.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all

% z variable calibration

z_r=[0.025, 0.1, 0.2, 0.3, 0.4, 0.5];
z_m=[0.027, 0.099, 0.200, 0.301, 0.399, 0.495];
p_z=polyfit(z_m,z_r,4);
x_z=0:0.01:0.6;
y_z=polyval(p_z,x_z);
subplot(221);
plot(z_m,z_r,'o',x_z,y_z);
ylim([0 0.6]);
t_z=get(gca,'Title');
set(t_z,'Interpreter','latex','string','$z(m)$');
xlabel('Measured values')
ylabel('Real Values')

% roll variable calibration
roll_r=[-90, -70, -60, -45, -30, -20, 0, 20, 30, 45,60,70, 90];
roll_m=[-67.25, -54.17, -47.99, -38.26, -26.15,-17.15 ,2.26, 18.25, 27.46, 39.97, 48.10, 55.36, 68.54];
p_roll=polyfit(roll_m,roll_r,4);
x_roll=-70:5:70;
y_roll=polyval(p_roll,x_roll);
subplot(222);
plot(roll_m,roll_r,'o',x_roll,y_roll);
ylim([-100 100]);
t_roll=get(gca,'Title');
set(t_roll,'Interpreter','latex','string','$\phi(^o)$');
xlabel('Measured values')
ylabel('Real Values')

% pitch variable calibration
pitch_r=[-90,-70,-60,-45,-30,-20,0,20,30,45,60,70, 90];
pitch_m=[-69.15,-57.12,-45.45,-39.16,-27.45,-16.02,1.85, 17.25, 28.21, 40.10, 46.12, 56.26, 68.07];
p_pitch=polyfit(pitch_m,pitch_r,4);
x_pitch=-70:5:70;
y_pitch=polyval(p_pitch,x_pitch);
subplot(223);
plot(pitch_m,pitch_r,'o',x_pitch,y_pitch);
ylim([-100 100]);
t_pitch=get(gca,'Title');
set(t_pitch,'Interpreter','latex','string','$\theta(^o)$');
xlabel('Measured values')
ylabel('Real Values')

% yaw calibration
yaw_r=[-180,-150,-135,-120,-90,-60,-45,-30,0, 30, 45, 60, 90, 120, 135, 150,   180];
yaw_m=[-173.27,-159.18,-141.12,-115.12,-80.20,-55.14,-34.12,-27.90,0.55,29.25, 35.27, 57.27 82.61, 117.23 140.17, 160.17 172.25];
p_yaw=polyfit(yaw_m,yaw_r,4);
x_yaw=-175:5:175;
y_yaw=polyval(p_yaw,x_yaw);
subplot(224);
plot(yaw_m,yaw_r,'o',x_yaw,y_yaw);
ylim([-190 190]);
t_yaw=get(gca,'Title');
set(t_yaw,'Interpreter','latex','string','$\psi(^o)$');
xlabel('Measured values')
ylabel('Real Values')





