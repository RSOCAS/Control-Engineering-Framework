%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Indirect Calibration Process for main variables p, q and r.
% By Rafael Socas, Raquel Dormido, Maria Guinaldo and Sebastian Dormido.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
close all

p_z=[ -1.6074    2.1047   -0.8594    1.1244   -0.0048];
p_roll=[-0.0000    0.0000    0.0007    1.1093   -1.4338];
p_pitch=[-0.0000    0.0000    0.0005    1.1283   -1.2418];
p_yaw=[0.0000   -0.0000    0.0000    1.0718   -0.9506];

%kpis = xlsread('kpis_indirectos.xlsx');
load kpis.mat;
n1=500;
n2=1500;
roll=kpis(n1:n2,2);
roll_cali=polyval(p_roll,roll); % Roll Calibradas
roll_rate=kpis(n1:n2,3); % Roll_rate Medidas

pitch=kpis(n1:n2,4);
pitch_cali=polyval(p_pitch,pitch); % Pitch Calibradas
pitch_rate=kpis(n1:n2,5); % Pitch_rate Medidas

yaw=kpis(n1:n2,6);
yaw_cali=polyval(p_yaw,yaw); % Yaw Calibradas
yaw_rate=kpis(n1:n2,7); % Yaw_rate Medidas

n=(1:length(roll)).*0.01;


% ROLL
roll_rate_cal=[0;diff(roll_cali)./0.01];
subplot (331)
plot(n,roll,'k',n,roll_cali,'b');
legend('measured','calibrated')
xlim([0 10])
t_roll=get(gca,'Title');
set(t_roll,'Interpreter','latex','string','$\phi(^o)$');
subplot (334)
plot(n,roll_rate)
t_roll=get(gca,'Title');
set(t_roll,'Interpreter','latex','string','$p(^o/s)$ Measured');
xlim([0 10])
ylim([-150 150]);
subplot(337)
plot(n,roll_rate_cal);
t_roll=get(gca,'Title');
set(t_roll,'Interpreter','latex','string','$p(^o/s)$ calculated from calibrated $\phi$');
xlim([0 10]) 
xlabel('t(s)')
ylim([-150 150]);

% PITCH
pitch_rate_cal=[0;diff(pitch_cali)./0.01];
subplot (332)
plot(n,pitch,'k',n,pitch_cali,'b');
legend('measured','calibrated')
xlim([0 10])
t_pitch=get(gca,'Title');
set(t_pitch,'Interpreter','latex','string','$\theta(^o)$');
subplot (335)
plot(n,pitch_rate)
t_pitch=get(gca,'Title');
set(t_pitch,'Interpreter','latex','string','$q(^o/s)$ Measured');
xlim([0 10])
ylim([-150 150]);
subplot(338)
plot(n,pitch_rate_cal);
t_pitch=get(gca,'Title');
set(t_pitch,'Interpreter','latex','string','$q(^o/s)$ calculated from calibrated $\theta$');
xlim([0 10])
xlabel('t(s)')
ylim([-150 150]);

% YAW
yaw_rate_cal=[0;diff(yaw_cali)./0.01];
subplot (333)
plot(n,yaw,'k',n,yaw_cali,'b');
legend('measured','calibrated')
xlim([0 10])
t_yaw=get(gca,'Title');
set(t_yaw,'Interpreter','latex','string','$\psi(^o)$');
subplot (336)
plot(n,yaw_rate)
t_yaw=get(gca,'Title');
set(t_yaw,'Interpreter','latex','string','$r(^o/s)$ Measured');
xlim([0 10])
ylim([-150 150]);
subplot(339)
plot(n,yaw_rate_cal);
t_yaw=get(gca,'Title');
set(t_yaw,'Interpreter','latex','string','$r(^o/s)$ calculated from calibrated $\psi$');
xlim([0 10])
xlabel('t(s)')
ylim([-150 150]);
pause

%Calibrado indirecto

close all;
l_a=400;
p_roll_rate=polyfit(roll_rate,roll_rate_cal,6);
x_roll=roll_rate(1:l_a);
y_roll=polyval(p_roll_rate,x_roll);
subplot(321)
plot(x_roll,roll_rate_cal(1:l_a),'o',x_roll,y_roll,'*');
t_roll=get(gca,'Title');
set(t_roll,'Interpreter','latex','string','$p(^o/s)$');
xlabel('Measured values')
ylabel('Calculated Values')

p_pitch_rate=polyfit(pitch_rate,pitch_rate_cal,6);
x_pitch=pitch_rate(1:l_a);
y_pitch=polyval(p_pitch_rate,x_pitch);
subplot(323)
plot(x_pitch,pitch_rate_cal(1:l_a),'o',x_pitch,y_pitch,'*');
t_pitch=get(gca,'Title');
set(t_pitch,'Interpreter','latex','string','$q(^o/s)$');
xlabel('Measured values')
ylabel('Calculated Values')

p_yaw_rate=polyfit(yaw_rate,yaw_rate_cal,6);
x_yaw=yaw_rate(1:l_a);
y_yaw=polyval(p_yaw_rate,x_yaw);
subplot(325)
plot(x_yaw,yaw_rate_cal(1:l_a),'o',x_yaw,y_yaw,'*');
t_yaw=get(gca,'Title');
set(t_yaw,'Interpreter','latex','string','$r(^o/s)$');
xlabel('Measured values')
ylabel('Calculated Values')


% Calculamos las variables reconstruidas

roll_rate_cali=polyval(p_roll_rate,roll_rate);
pitch_rate_cali=polyval(p_pitch_rate,pitch_rate);
yaw_rate_cali=polyval(p_yaw_rate,yaw_rate);

%Roll_rate
subplot (322)
plot(n,roll_rate,'k',n,roll_rate_cali,'b');
legend('measured','calibrated')
xlim([0 10])
ylim([-150 150]);
t_roll=get(gca,'Title');
set(t_roll,'Interpreter','latex','string','$p(^o/s)$');
xlabel('t(s)')

%Pitch_rate
subplot (324)
plot(n,pitch_rate,'k',n,pitch_rate_cali,'b');
legend('measured','calibrated')
xlim([0 10])
ylim([-150 150]);
t_roll=get(gca,'Title');
set(t_roll,'Interpreter','latex','string','$q(^o/s)$');
xlabel('t(s)')

%Yaw_rate
subplot (326)
plot(n,yaw_rate,'k',n,yaw_rate_cali,'b');
legend('measured','calibrated')
xlim([0 10])
ylim([-150 150]);
t_roll=get(gca,'Title');
set(t_roll,'Interpreter','latex','string','$r(^o/s)$');
xlabel('t(s)')
