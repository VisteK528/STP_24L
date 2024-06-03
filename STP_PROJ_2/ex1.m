clear;
% Load project data
load("stp_proj2_data.mat")

% Export setup
set(0, 'defaulttextinterpreter','latex');
set(0, 'DefaultLineLineWidth',1);
set(0, 'DefaultStairLineWidth',1);
resolution_dpi = 300;
export_pictures = false;

% Compute discrete transfer function based on continuous transfer function
Gc = tf([Ko], [T1*T2 T1 + T2 1],'InputDelay', To);
Gd = c2d(Gc, Tp, 'zoh');

% Continuous and discrete transfer function gains
Gc_gain = dcgain(Gc);
Gd_gain = dcgain(Gd);

% Step respones
figure;
step(Gc, 'b');
hold on;
step(Gd, 'r--');

legend("$G(s)$", "$G(z)$", 'fontsize', 12, 'Interpreter','latex');
x0=10;
y0=10;
width=854;
height=480;
set(gcf,'position',[x0,y0,width,height]);
grid(gca,'minor');
title('');

xlabel('$t$', 'fontsize', 14, 'Interpreter','latex');
ylabel('$y$', 'fontsize', 14, 'Interpreter','latex');

file_name = "images/ex1_step_responses.png";
if export_pictures
    exportgraphics(gcf, file_name, 'Resolution', resolution_dpi);
end
