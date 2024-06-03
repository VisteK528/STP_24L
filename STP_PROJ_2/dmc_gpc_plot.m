
set(0, 'defaulttextinterpreter','latex');
set(0, 'DefaultLineLineWidth',1);
set(0, 'DefaultStairLineWidth',1);
resolution_dpi = 300;
export_pictures = true;

D = 85;
N = 20;
Nu = 2;
lambda = 4;
iterations = 300;
kstart = 100;

[y_dmc, u_dmc] = ex4_dmc(N, Nu, D, lambda, kstart, iterations, 1, 0, 0.0, 200);
[y_gpc, u_gpc] = ex7_gpc(N, Nu, D, lambda, kstart, iterations, 1, 0, 0.0, 200);

n = length(y_dmc);

figure;
stairs(1:n, y_dmc);
hold on;
stairs(1:n, y_gpc, '--');

x0=10;
y0=10;
width=600;
height=600;
set(gcf,'position',[x0,y0,width,height]);
grid(gca,'minor');
title('');
legend("y_{dmc}", "y_{gpc}", 'fontsize', 12);

xlabel('$k$', 'fontsize', 14, 'Interpreter','latex');
ylabel('$y$', 'fontsize', 14, 'Interpreter','latex');

file_name = "images/ex8_dmc_gpc_y.png";
if export_pictures
    exportgraphics(gcf, file_name, 'Resolution', resolution_dpi);
end



figure;
stairs(1:n, u_dmc);
hold on;
stairs(1:n, u_gpc, '--');

x0=10;
y0=10;
width=600;
height=600;
set(gcf,'position',[x0,y0,width,height]);
grid(gca,'minor');
title('');
legend("u_{dmc}", "u_{gpc}", 'fontsize', 12);


xlabel('$k$', 'fontsize', 14, 'Interpreter','latex');
ylabel('$u$', 'fontsize', 14, 'Interpreter','latex');

file_name = "images/ex8_dmc_gpc_u.png";
if export_pictures
    exportgraphics(gcf, file_name, 'Resolution', resolution_dpi);
end
