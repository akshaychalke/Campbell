%% Written by: Akshay Prafulla Chalke
% This script is intended to take in frequency and rpm data for number of 
% cases and the various operating lines and their labels in form of excel 
% files and user input for rpm and EO lines and plot the campbell diagram

%% Clearing functions
clc
clear
close all

%% Path for data files

path = 'C:\Users\chalke\OneDrive - KTH\Akshay\Matlab Codes\Campbell\Data\';

%% Data input

cases = [2];

RPM = inputdlg('Enter the rotation speed in rpm','Rev/min', [1 50]);        % Rotation speed in rpm input box
RPM = str2double(RPM{1});                                                   % Store rotation speed as double data

% Main Campbell data
for i=cases
    Camp{i} = readtable([path num2str(i) '\Campbell_Data.csv']);            % Reading the rotation speed steps and corrresponding mode frequencies
end

% Reading operational speedlines
OP_lines = readtable([path '\Op_speeds.csv']);

labels = readtable([path '\Labels.csv']);
labels = string(labels{:,1});

%% Data Rev 04

N = Camp{1,cases(1)}{:,1}.*RPM;

%% EO Lines

Max_EO = inputdlg('Enter the maximum Engine order excitation','EO', [1 50]);
Max_EO = str2double(Max_EO{1});

EO = (1:1:Max_EO).*(N./60);

%% Plots

figure()
for i=cases
    for j=[2 3 4]
    plot(N,Camp{1,i}{:,j},'-','LineWidth',3,'MarkerSize',10,'MarkerFaceColor',[0.5,0.5,0.5])
    hold on
    end
end
grid on

xline(OP_lines{1,3},':','color',[0.9 0.1 0.5],'LineWidth',3)
xline(OP_lines{2,3},':','color',[0 1 0],'LineWidth',3)
xline(OP_lines{3,3},':','color',[0 0 1],'LineWidth',3)
xline(OP_lines{4,3},':','color',[1 0 1],'LineWidth',3)
xline(OP_lines{5,3},':','color',[0 0 0],'LineWidth',3)
xline(OP_lines{6,3},'-','color',[1 0 0],'LineWidth',3)
xline(OP_lines{7,3},':','color',[0.2 .4 .7],'LineWidth',3)
xline(OP_lines{8,3},':','color',[.7 .2 .7],'LineWidth',3)
xline(OP_lines{9,3},':','color',[.5 .7 .2],'LineWidth',3)

for i=1:1:Max_EO
    plot(N,EO(:,i),'-k','LineWidth',1,'MarkerSize',10,'MarkerFaceColor',[0.5,0.5,0.5])
end

plot([0 1195 2390],[97.411 100.58 109.52],'pr--','LineWidth',3,'MarkerSize',10,'MarkerFaceColor',[0.5,0.5,0.5])
plot([0 1195 2390],[304.32 305.73 309.87],'pr--','LineWidth',3,'MarkerSize',10,'MarkerFaceColor',[0.5,0.5,0.5])
plot([0 1195 2390],[520.68 523.5 531.94],'pr--','LineWidth',3,'MarkerSize',10,'MarkerFaceColor',[0.5,0.5,0.5])

xlim([0 3000])
ylim([0 550])
xlabel('Rotation Speed (rpm)')
ylabel('Modal Frequency (Hz)')
legend(labels,'Location','eastoutside')
set(gca,'FontSize', 20)
set(gcf,'Position',[10 10 900 500])
hold off