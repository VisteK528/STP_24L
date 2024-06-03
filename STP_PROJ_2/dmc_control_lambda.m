set(0, 'defaulttextinterpreter','latex');
set(0, 'DefaultLineLineWidth',1);
set(0, 'DefaultStairLineWidth',1);

D = 85;
N = 20;
Nu = 2;
start = 20;
kend = 100;
K_0 = 1;
T_0 = 0;
z_value = 0.1;
z_step = 100;
lambda_list = [0.1, 1, 2, 5, 50];

yzad = zeros(kend, 1);
yzad(start:end) = 1;
len = length(yzad);

y_list = zeros(length(lambda_list), len);
u_list = zeros(length(lambda_list), len);


for i=1:length(lambda_list)
    [y, u] = ex4_dmc(N, Nu, D, lambda_list(i), start, kend, K_0, T_0, z_value, z_step);
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
for i=1:length(lambda_list)
    stairs(1:len, y_list(i, :));
    hold on;
end
stairs(1:length(yzad), yzad, '--');

x0=10;
y0=10;
width=1280;
height=720;
set(gcf,'position',[x0,y0,width,height]);
grid(gca,'minor');
title('');

legend("$\lambda=0.1$", "$\lambda=1$", "$\lambda=2$", "$\lambda=5$", "$\lambda=50$", "$y_{zad}$", 'fontsize', 12, 'Interpreter','latex', 'Location', 'best');
xlabel('$k$', 'fontsize', 14, 'Interpreter','latex');
ylabel('$y$', 'fontsize', 14, 'Interpreter','latex');

file_name = "images/ex5_dmc_y_lambda.png";
if export_pictures
    exportgraphics(gcf, file_name, 'Resolution', resolution_dpi);
end


figure;
for i=1:length(lambda_list)
    stairs(1:len, u_list(i, :));
    hold on;
end

x0=10;
y0=10;
width=1280;
height=720;
set(gcf,'position',[x0,y0,width,height]);
grid(gca,'minor');
title('');

legend("$\lambda=0.1$", "$\lambda=1$", "$\lambda=2$", "$\lambda=5$", "$\lambda=50$", 'fontsize', 12, 'Interpreter','latex', 'Location', 'best');
xlabel('$k$', 'fontsize', 14, 'Interpreter','latex');
ylabel('$u$', 'fontsize', 14, 'Interpreter','latex');

file_name = "images/ex5_dmc_u_lambda.png";
if export_pictures
    exportgraphics(gcf, file_name, 'Resolution', resolution_dpi);
end