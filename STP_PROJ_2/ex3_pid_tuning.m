load("stp_proj2_data.mat")
Gc = tf([Ko], [T1*T2 T1 + T2 1],'InputDelay', To);

Kk = 0.661505;
R = pidstd(Kk);

k_end = 100;
sys_cl = feedback(R*Gc, 1);
[y, t] = step(sys_cl, k_end);

% Export setup
set(0, 'defaulttextinterpreter','latex');
set(0, 'DefaultLineLineWidth',1);
set(0, 'DefaultStairLineWidth',1);
resolution_dpi = 300;
export_pictures = true;

figure;
plot(t, y);


x0=10;
y0=10;
width=854;
height=480;
set(gcf,'position',[x0,y0,width,height]);
grid(gca,'minor');
title('');

xlabel('$t$', 'fontsize', 14, 'Interpreter','latex');
ylabel('$y$', 'fontsize', 14, 'Interpreter','latex');

file_name = "images/ex3_pid_tuning.png";
if export_pictures
    exportgraphics(gcf, file_name, 'Resolution', resolution_dpi);
end