close all
clear all

x = linspace(0,30,1000);
y = struve(0,x);

fig1 = figure(1);
grid on
hold on

plot(x,y)