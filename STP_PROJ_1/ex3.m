% Simulation setup
clear;
x_0 = [5 -1 3];
A = [-21  -146  -336; 1     0     0; 0     1     0];
B = [1; 0; 0];
C = [1 7.5 12.5];
D = 0;
t_fin = 6;

% Export setup
set(0, 'defaulttextinterpreter','latex');
set(0, 'DefaultLineLineWidth',1);
set(0, 'DefaultStairLineWidth',1);
resolution_dpi = 400;
export_pictures = true;

sb_vec = [-3 -6.9 -9];

for i=1:3
    % Generate new K vector
    k = acker(A, B, sb_vec(i)*ones(1, 3));

    k_regulator_sim = sim("ex3_k_ss_regulator_sim.slx",'Solver','ode45','StartTime','0','StopTime', int2str(t_fin));
    x_data = k_regulator_sim.get("x_timeseries").Data;
    u_data = k_regulator_sim.get("u").Data;
    t = k_regulator_sim.get("x_timeseries").Time;

    % Plot the state variables
    file_name = "images/ex3_regulator_k_variables_sb="+ sb_vec(i) +".png";
    figure;

    plot(t, x_data(:, 1), '-.');
    hold on;
    plot(t, x_data(:, 2), '--');
    hold on;
    plot(t, x_data(:, 3)), '-.';
    hold off;

    padding_left = 0.1; 
    yLimits_left = ylim(gca);
    newMin_left = yLimits_left(1) - padding_left*(yLimits_left(2)-yLimits_left(1));
    newMax_left = yLimits_left(2) + padding_left*(yLimits_left(2)-yLimits_left(1));
    ylim(gca, [newMin_left, newMax_left]);
    
    xlabel('$t(s)$', 'fontsize', 18);
    ylabel('$x(t)$', 'fontsize', 18);
    
    % General export setup
    legend("$x_1(t)$", "$x_2(t)$", "$x_3(t)$", 'fontsize', 16, 'Interpreter','latex');
    x0=10;
    y0=10;
    width=1280;
    height=720;
    set(gcf,'position',[x0,y0,width,height]);
    grid(gca,'minor');

    if export_pictures
        exportgraphics(gcf, file_name, 'Resolution', resolution_dpi);
    end


    file_name = "images/ex3_regulator_k_control_signal_sb="+ sb_vec(i) +".png";
    figure;

    % Left Yaxis plot
    plot(t, u_data);
    hold on;

  
    % Left Yaxis limits setup
    padding_left = 0.1; 
    yLimits_left = ylim(gca);
    newMin_left = yLimits_left(1) - padding_left*(yLimits_left(2)-yLimits_left(1));
    newMax_left = yLimits_left(2) + padding_left*(yLimits_left(2)-yLimits_left(1));
    ylim(gca, [newMin_left, newMax_left]);
    
    xlabel('$t(s)$', 'fontsize', 18);
    ylabel('$u(t)$', 'fontsize', 18);
    
    % General export setup
    x0=10;
    y0=10;
    width=1280;
    height=720;
    set(gcf,'position',[x0,y0,width,height]);
    grid(gca,'minor');

    if export_pictures
        exportgraphics(gcf, file_name, 'Resolution', resolution_dpi);
    end
end