close all
clear all

x = linspace(0,40,1000);
y = struve(0,x);

fig1 = figure(1);
grid on
hold on

yline(0)

plot(x,y)