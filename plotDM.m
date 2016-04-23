close all;
clear;
clc;

addpath(genpath('./Code/uWaveMatlab/functions'));

load distanceMatrix.mat


% plot distance matrix
gino_ges = zeros(4,10);
henry_ges = zeros(4,10);
for ges = 1:4
    for at=1:10
       gino_ges(ges, at) = distanceMatrix(1,ges,at);
       henry_ges(ges, at) = distanceMatrix(2,ges,at);
    end
end
att = [1,2,3,4,5,6,7,8,9,10];

fighandles=cell(1,4);

%Gesture 4
fighandles{1}=figure; 
hold all
plot(att, gino_ges(1,:),'Color','r','LineWidth',1,'Marker','o');
plot(att, henry_ges(1,:),'Color','b','LineWidth',1,'Marker','o');
legend('Prover','Attacker');
xlabel('Attempt Number');
ylabel('DTW Distance');
% title('DTW Distance to Verifier');
saveFigure(fighandles{1},'./Data/plots/simultaneousplots/numeight');

hold

fighandles{2}=figure;  
hold all
plot(att, gino_ges(2,:),'Color','r','LineWidth',1,'Marker','o');
plot(att, henry_ges(2,:),'Color','b','LineWidth',1,'Marker','o');
legend('Prover','Attacker');
xlabel('Attempt Number');
ylabel('DTW Distance');
saveFigure(fighandles{2},'./Data/plots/simultaneousplots/zi');

hold

fighandles{3}=figure;  
hold all
plot(att, gino_ges(3,:),'Color','r','LineWidth',1,'Marker','o');
plot(att, henry_ges(3,:),'Color','b','LineWidth',1,'Marker','o');
legend('Prover','Attacker');
xlabel('Attempt Number');
ylabel('DTW Distance');
saveFigure(fighandles{3},'./Data/plots/simultaneousplots/ru');

hold

fighandles{4}=figure; 
hold all
plot(att, gino_ges(4,:),'Color','r','LineWidth',1,'Marker','o');
plot(att, henry_ges(4,:),'Color','b','LineWidth',1,'Marker','o');
legend('Prover','Attacker');
xlabel('Attempt Number');
ylabel('DTW Distance');
saveFigure(fighandles{4},'./Data/plots/simultaneousplots/box');