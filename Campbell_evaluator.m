clc
clear
close all

%% Path for data files

path = 'C:\Users\chalke\OneDrive - KTH\Akshay\Matlab Codes\Campbell\Data\';

%% Data input

RPM = inputdlg('Enter the rotation speed in rpm','Rev/min', [1 50]);        % Rotation speed in rpm input box
RPM = str2double(RPM{1});                                                   % Store rotation speed as double data

% Main Campbell data
for i=[1 2 3 4]
    Camp{i} = readtable([path num2str(i) '\Campbell_Data.csv']);            % Reading the rotation speed steps and corrresponding mode frequencies
end

% Reading operational speedlines
OP_lines = readtable([path '\Op_speeds.csv']);
N_OP = size(OP_lines,1);

% Dovetail Thickness

D_thk = [17 20 22 24];
%% Data Rev 04

N = Camp{1,1}{:,1}.*RPM;

%% EO Lines

Max_EO = inputdlg('Enter the maximum Engine order excitation','EO', [1 50]);
Max_EO = str2double(Max_EO{1});

EO = (1:1:Max_EO).*(N./60);

%% Evaluation

C=3;
C_O=4;
for n= 1:1:4
    Mode1_C = abs(EO - Camp{1,n}{C,2});
    Mode1_C_O = abs(EO - Camp{1,n}{C_O,2});

    Mode1_Cruise(n) = min(Mode1_C(C,2))*60;
    Mode1_Cruise_O(n) = min(Mode1_C_O(C_O,2))*60;
end
s =3;
for p=1:1:3
    per = (Camp{1,(p+1)}{s,2}-Camp{1,p}{s,2})/Camp{1,p}{s,2}
end
%% Plotting

figure()
plot(D_thk,Mode1_Cruise,'LineWidth',3)
hold on
%yline(0,'-r')
xlim([16 25])
grid on
xlabel('Thickness of Dovetail')
ylabel('RPM')

figure()
plot(D_thk,Mode1_Cruise_O,'LineWidth',3)
hold on
xlim([16 25])
grid on
xlabel('Thickness of Dovetail')
ylabel('RPM')
%% Reserve Code
% Mode1_C1 = abs(EO - Camp{1,n}{C,2});
% [Mode1_C,EO_cross] = min(min(abs(EO - Camp{1,n}{c,2}))) ;