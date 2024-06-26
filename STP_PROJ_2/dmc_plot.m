set(0, 'defaulttextinterpreter','latex');
set(0, 'DefaultLineLineWidth',1);
set(0, 'DefaultStairLineWidth',1);

D = 85;
N = 20;
Nu = 2;
lambda = 5;
start = 20;
kend = 100;
K_0 = 1;
%K_0 = 1.625;
T_0 = 0;
z_value = 0;
z_step = 100;

[y, u] = ex4_dmc(N, Nu, D, lambda, start, kend, K_0, T_0, z_value, z_step);
len = length(y);
yzad = zeros(kend, 1);
yzad(start:end) = 1;

% Plot graphs
set(0, 'defaulttextinterpreter','latex');
set(0, 'DefaultLineLineWidth',1);
set(0, 'DefaultStairLineWidth',1);
resolution_dpi = 300;
export_pictures = true;

figure;
stairs(1:len, y);
hold on;
stairs(1:len, yzad, '--');

x0=10;
y0=10;
width=1280;
height=720;
set(gcf,'position',[x0,y0,width,height]);
grid(gca,'minor');
title('');

legend("$y(k)$", "$y_{zad}(k)$", 'fontsize', 12, 'Interpreter','latex');
xlabel('$k$', 'fontsize', 14, 'Interpreter','latex');
ylabel('$y$', 'fontsize', 14, 'Interpreter','latex');

file_name = "images/ex5_dmc_y_tuned_big.png";
if export_pictures
    exportgraphics(gcf, file_name, 'Resolution', resolution_dpi);
end

figure;
stairs(1:len, u);

x0=10;
y0=10;
width=1280;
height=720;
set(gcf,'position',[x0,y0,width,height]);
grid(gca,'minor');
title('');

xlabel('$k$', 'fontsize', 14, 'Interpreter','latex');
ylabel('$u$', 'fontsize', 14, 'Interpreter','latex');

file_name = "images/ex5_dmc_u_tuned_big.png";
if export_pictures
    exportgraphics(gcf, file_name, 'Resolution', resolution_dpi);
end