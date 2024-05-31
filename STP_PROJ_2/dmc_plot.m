set(0, 'defaulttextinterpreter','latex');
set(0, 'DefaultLineLineWidth',1);
set(0, 'DefaultStairLineWidth',1);

[y, u] = ex4_dmc(50, 10, 120, 20, 200);
n = length(y);

figure;
stairs(1:n, y);
hold on;
stairs(1:n, u);

x0=10;
y0=10;
width=1280;
height=720;
set(gcf,'position',[x0,y0,width,height]);
grid(gca,'minor');
title('');