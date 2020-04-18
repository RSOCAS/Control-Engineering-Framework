%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Delay Analysis for the onboard - offboard controllers.
% By Rafael Socas, Raquel Dormido, Maria Guinaldo and Sebastian Dormido.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Delay analysis without packet losses
clear all
close all
% filename1 = 'Datos_delay_SPP.xlsx';
% DSPP = xlsread(filename1);
load DSPP.mat
xbin_dspp=0.0153:0.00002:0.0159;
subplot (211)
plot(DSPP)
xlabel('Samples')
ylabel('Loop delay (s)')
subplot(212)
histogram(DSPP,xbin_dspp)
xlabel('Loop delay (s)')
ylabel('Frequency')
pause


% Delay analysis without packet losses 

%filename2 = 'Datos_delay_CPP.xlsx';
%DCPP = xlsread(filename2);
load DCPP.mat
xbin_dcpp=0.001:0.001:0.05;
subplot(111)
plot(DCPP)
xlabel('t(s)')
ylabel('Loop delay (s)')

pause
