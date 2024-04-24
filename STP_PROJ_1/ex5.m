% Simulation setup
x_0 = [5 -1 3];
xo_0 = [0 0 0];
x_fin = [0 0 0];

t_0 = 0;
t_fin = 10;

A = [-21  -146  -336; 1     0     0; 0     1     0];
B = [1; 0; 0];
C = [1 7.5 12.5];
D = 0;

sb = -6.82;
k = acker(A, B, [sb sb sb]);

% Export setup
set(0, 'defaulttextinterpreter','latex');
set(0, 'DefaultLineLineWidth',1);
set(0, 'DefaultStairLineWidth',1);
resolution_dpi = 400;
export_pictures = true;

s0_vec = [-2 -6.2 -9];
for i=1:3
    s0 = s0_vec(i);
    L = acker(A', C', [s0 s0 s0]);
    observator_sim = sim("ex5_ex6_observator.slx",'Solver','ode45','StartTime','0','StopTime', int2str(t_fin));
    x_data = observator_sim.get("x_timeseries").Data;
    x_est_data = observator_sim.get("x_est_timeseries").Data;
    t = observator_sim.get("x_timeseries").Time;
    
    for j=1:3
        file_name = "images/ex5_observer_x" + j + "_s0="+ s0_vec(i) +".png";
        figure;
        plot(t, x_data(:, j));
        hold on;
        plot(t, x_est_data(:, j), '--');
        hold off;
    
        padding_left = 0.1; 
        yLimits_left = ylim(gca);
        newMin_left = yLimits_left(1) - padding_left*(yLimits_left(2)-yLimits_left(1));
        newMax_left = yLimits_left(2) + padding_left*(yLimits_left(2)-yLimits_left(1));
        ylim(gca, [newMin_left, newMax_left]);
        
        xlabel('$t(s)$', 'fontsize', 18);
        y_label_str = "$x_"+int2str(j)+"(t)$";
        ylabel(y_label_str, 'fontsize', 18);
        
        % General export setup
        legend("$x_" + int2str(j) + "(t)$", "$\hat{x_"+ int2str(j) +"}(t)$", 'fontsize', 16, 'Interpreter','latex');
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
end
