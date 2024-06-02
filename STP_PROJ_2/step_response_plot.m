clear;
set(0, 'defaulttextinterpreter','latex');
set(0, 'DefaultLineLineWidth',1);
set(0, 'DefaultStairLineWidth',1);
resolution_dpi = 300;
export_pictures = true;

D = 40;
N = 45;
kstart = 15;
y = ex4_step_response(kstart, N, D);
y_zad(1:D+N+kstart) = 3.4;

figure;
stairs(1:D+N+kstart, y);
hold on;
stairs(1:D+N+kstart, y_zad, '--');

x0=10;
y0=10;
width=854;
height=480;
set(gcf,'position',[x0,y0,width,height]);
grid(gca,'minor');
title('');

xlabel('$k$', 'fontsize', 14, 'Interpreter','latex');
ylabel('$y$', 'fontsize', 14, 'Interpreter','latex');

file_name = "images/ex2_diff_eq_step_response.png";
if export_pictures
    exportgraphics(gcf, file_name, 'Resolution', resolution_dpi);
end


