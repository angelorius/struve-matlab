close all
clear all

xmax = 50;
xmin = 0;
resolution = 3000;
dx = (xmax-xmin)/resolution;
x = linspace(xmin, xmax, resolution);
v = 1;
y = struve(v,x);

fig1 = figure(1);
grid on
hold on

yline(0)

plot(x,y)
xlim([xmin xmax])

fig2 = figure(2);
grid on 
hold on

y2 = gradient(y,dx);

plot(x,y2)
xlim([xmin+1 xmax-1])

