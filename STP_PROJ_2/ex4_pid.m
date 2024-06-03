clear all;
load("stp_proj2_data.mat")

% Digital PID parameters
Kk = 0.661505;
Tk = 19.6;
[r2, r1, r0] = discrete_pid_parameters(Kk, Tk, Tp);

% General settings
iterations = 250;
step_time = 20;
kstart = 30; 
yzad(1:step_time) = 0;
yzad(step_time:iterations) = 1;
u(1:kstart) = 0; y(1:kstart) = 0; e(1:kstart) = 0;
K_0 = 1; T_0 = 0;
[c, b] = diff_eq_coeffs;

% Main loop
for k=kstart:iterations
    % Generate process output
    y(k) = y(k-2)*b(2) + y(k-1)*b(1) + K_0*(u(k-12-T_0)*c(2) + ...
        u(k-11-T_0)*c(1));
    
    % Compute error
    e(k) = yzad(k) - y(k);
    
    % Compute manipulate variable for discrete time k
    u(k) = r2*e(k-2) + r1*e(k-1) + r0*e(k) + u(k-1);
end
len = length(y);

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

file_name = "images/ex4_pid_sim_y_big.png";
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

file_name = "images/ex4_pid_sim_u_big.png";
if export_pictures
    exportgraphics(gcf, file_name, 'Resolution', resolution_dpi);
end


