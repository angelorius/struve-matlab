close all
clear all

x = linspace(0,50,1000);
v = 1;
y = struve(v,x);

fig1 = figure(1);
grid on
hold on

yline(0)

plot(x,y)