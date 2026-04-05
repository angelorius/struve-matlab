close all
clear all

x = linspace(0,29,1000);
y = struve(1,x);

fig1 = figure(1);
grid on
hold on

yline(0)

plot(x,y)