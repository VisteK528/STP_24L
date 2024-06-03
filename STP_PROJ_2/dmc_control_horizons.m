set(0, 'defaulttextinterpreter','latex');
set(0, 'DefaultLineLineWidth',1);
set(0, 'DefaultStairLineWidth',1);

D = 85;
N = 20;
lambda = 1;
start = 20;
kend = 100;
K_0 = 1;
T_0 = 0;
z_value = 0.1;
z_step = 100;
Nu_list = [1, 2, 5, 10, 20];

yzad = zeros(kend, 1);
yzad(start:end) = 1;
len = length(yzad);

y_list = zeros(length(Nu_list), len);
u_list = zeros(length(Nu_list), len);


for i=1:length(Nu_list)
    [y, u] = ex4_dmc(N, Nu_list(i), D, lambda, start, kend, K_0, T_0, z_value, z_step);
    y_list(i, :) = y;
    u_list(i, :) = u;
end


% Plot graphs
set(0, 'defaulttextinterpreter','latex');
set(0, 'DefaultLineLineWidth',1);
set(0, 'DefaultStairLineWidth',1);
resolution_dpi = 300;
export_pictures = true;

figure;
for i=1:length(Nu_list)
    stairs(1:len, y_list(i, :));
    hold on;
end
stairs(1:length(yzad), yzad, '--');

x0=10;
y0=10;
width=480;
height=480;
set(gcf,'position',[x0,y0,width,height]);
grid(gca,'minor');
title('');

legend("$Nu=1$", "$Nu=2$", "$Nu=5$", "$Nu=10$", "$Nu=20$", "$y_{zad}$", 'fontsize', 12, 'Interpreter','latex', 'Location', 'best');
xlabel('$k$', 'fontsize', 14, 'Interpreter','latex');
ylabel('$y$', 'fontsize', 14, 'Interpreter','latex');

file_name = "images/ex5_dmc_y_control_horizons.png";
if export_pictures
    exportgraphics(gcf, file_name, 'Resolution', resolution_dpi);
end


figure;
for i=1:length(Nu_list)
    stairs(1:len, u_list(i, :));
    hold on;
end

x0=10;
y0=10;
width=480;
height=480;
set(gcf,'position',[x0,y0,width,height]);
grid(gca,'minor');
title('');

legend("$Nu=1$", "$Nu=2$", "$Nu=5$", "$Nu=10$", "$Nu=20$", 'fontsize', 12, 'Interpreter','latex', 'Location', 'best');
xlabel('$k$', 'fontsize', 14, 'Interpreter','latex');
ylabel('$u$', 'fontsize', 14, 'Interpreter','latex');

file_name = "images/ex5_dmc_u_control_horizons.png";
if export_pictures
    exportgraphics(gcf, file_name, 'Resolution', resolution_dpi);
end