clear;
set(0, 'defaulttextinterpreter','latex');
set(0, 'DefaultLineLineWidth',1);
set(0, 'DefaultStairLineWidth',1);
resolution_dpi = 300;
export_pictures = true;

D = 40;
N = 40;
kstart = 13;
step = 20;
[c, b] = diff_eq_coeffs;
y = ex4_step_response(kstart, N, D, c, b);
y = [zeros(step-kstart, 1); y];
y_zad = zeros(D+N+step, 1);
y_zad(step:end) = 1;

figure;
stairs(1:D+N+step, y);
hold on;
stairs(1:D+N+step, y_zad, '--');

x0=10;
y0=10;
width=854;
height=480;
set(gcf,'position',[x0,y0,width,height]);
grid(gca,'minor');
title('');

legend("y", "y_{zad}", 'fontsize', 12, 'Location', 'best');
xlabel('$k$', 'fontsize', 14, 'Interpreter','latex');
ylabel('$y$', 'fontsize', 14, 'Interpreter','latex');

file_name = "images/ex2_diff_eq_step_response.png";
if export_pictures
    exportgraphics(gcf, file_name, 'Resolution', resolution_dpi);
end


