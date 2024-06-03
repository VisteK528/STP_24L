
% Obszar stabilności PID
%To = [1, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0];
%Ko = [1.5850731, 1.5145671, 1.451411, 1.393851095, 1.34067955, 1.2910585, 1.2444031, 1.2003005, 1.1584599, 1.118666, 1.0807684];

% Obszar stabilności DMC
% To = [1, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0];
% Ko = [2.15465, 2.090025, 2.005645, 1.910946, 1.8132915, 1.7179889, 1.61668, 1.365, 1.2125, 1.1301, 1.10105];

% Obszar stabilności GPC
To = [1, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0];
Ko = [4.1835, 4.13755, 4.06945, 3.99019, 3.90685, 3.8236, 3.7429, 3.66605, 3.59365, 3.5258, 3.4627];

% Plot graphs
set(0, 'defaulttextinterpreter','latex');
set(0, 'DefaultLineLineWidth',1);
set(0, 'DefaultStairLineWidth',1);
resolution_dpi = 300;
export_pictures = true;

figure;
plot(To, Ko, '-o');

x0=10;
y0=10;
width=854;
height=480;
set(gcf,'position',[x0,y0,width,height]);
grid(gca,'minor');
title('');

xlabel('$T_o/T_{nom}$', 'fontsize', 14, 'Interpreter','latex');
ylabel('$K_o/K_{nom}$', 'fontsize', 14, 'Interpreter','latex');

file_name = "images/ex9_gpc_stability.png";
if export_pictures
    exportgraphics(gcf, file_name, 'Resolution', resolution_dpi);
end