
set(0, 'defaulttextinterpreter','latex');
set(0, 'DefaultLineLineWidth',1);
set(0, 'DefaultStairLineWidth',1);

D = 120;
N = 30;
Nu = 10;
lambda = 20;
iterations = 200;

[y_dmc, u_dmc] = ex4_dmc(N, Nu, D, lambda, iterations);
[y_gpc, u_gpc] = ex7_gpc(N, Nu, D, lambda, iterations);

n = length(y_dmc);

figure;
stairs(1:n, y_dmc);
hold on;
stairs(1:n, y_gpc);

x0=10;
y0=10;
width=1280;
height=720;
set(gcf,'position',[x0,y0,width,height]);
grid(gca,'minor');
title('');
legend("$y_{dmc}(k)$", "$y_{gpc}$", 'fontsize', 12);


figure;
stairs(1:n, u_dmc);
hold on;
stairs(1:n, u_gpc);

x0=10;
y0=10;
width=1280;
height=720;
set(gcf,'position',[x0,y0,width,height]);
grid(gca,'minor');
title('');
legend("$u_{dmc}(k)$", "$u_{gpc}$", 'fontsize', 12);
