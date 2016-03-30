clear;
close all;
clc;

addpath('functions/');

tIn=0:0.015:1;
d=randi(50,size(tIn));
[t,Q]=uWaveQuant(tIn,d);

figure;
subplot(2,1,1);
plot(tIn,d);
xlabel('Time (s)');
ylabel('Value');
title('Raw Data');
hold on;
subplot(2,1,2);
plot(t,Q);
xlabel('Time (s)');
ylabel('Value');
title('Quantized Data');
hold off;