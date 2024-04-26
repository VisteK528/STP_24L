% Export setup
set(0, 'defaulttextinterpreter','latex');
set(0, 'DefaultLineLineWidth',1);
set(0, 'DefaultStairLineWidth',1);
resolution_dpi = 400;
export_pictures = true;
names = ["b", "b_mult"];

% Simulation setup
x_0 = [0 0 0];
x_fin = [0 0 0];

t_0 = 0;
t_fin = 6;

step_time = 1;
step_value = 1;

A = [-21  -146  -336; 1     0     0; 0     1     0];
B = [1; 0; 0];
C = [1 7.5 12.5];
D = 0;

Ar = [A zeros(3, 1); -C 0];
Br = [B; 0];

b_vec_coeff = [1 1.5];
poles = [-3 -9];

for i=1:2
    Br = Br.*b_vec_coeff(i);
    for j=1:2
        sb = poles(j);
        Kr = acker(Ar, Br, [sb sb sb sb]);
        k = Kr(1:3);
        Ke = Kr(4);

        int_reg_sim = sim("extra_ex_k_ss_regulator_int.slx",'Solver','ode45','StartTime','0','StopTime', int2str(t_fin));
        x_data = int_reg_sim.get("x_timeseries").Data;
        u_data = int_reg_sim.get("u").Data;
        y_data = int_reg_sim.get("y").Data;
        y_zad_data = int_reg_sim.get("y_zad").Data;
        t = int_reg_sim.get("x_timeseries").Time;

        % Y and Y_zad
        file_name = "images/extra_ex_y_y_zad_sb=" + int2str(sb) + "_" + names(i) + ".png";
        figure;
        plot(t, y_data);
        hold on;
        plot(t, y_zad_data, '--');
        hold off;
    
        padding_left = 0.1; 
        yLimits_left = ylim(gca);
        newMin_left = yLimits_left(1) - padding_left*(yLimits_left(2)-yLimits_left(1));
        newMax_left = yLimits_left(2) + padding_left*(yLimits_left(2)-yLimits_left(1));
        ylim(gca, [newMin_left, newMax_left]);
        
        xlabel('$t[s]$', 'fontsize', 18);
        y_label_str = "$y(t) \ y_{zad}(t)$";
        ylabel(y_label_str, 'fontsize', 18);
        
        % General export setup
        legend("$y(t)$", "$y_{zad}(t)$", 'fontsize', 16, 'Interpreter','latex');
        x0=10;
        y0=10;
        width=1280;
        height=720;
        set(gcf,'position',[x0,y0,width,height]);
        grid(gca,'minor');
    
        if export_pictures
            exportgraphics(gcf, file_name, 'Resolution', resolution_dpi);
        end

        % State variables
        file_name = "images/extra_ex_x_sb=" + int2str(sb) + "_" + names(i) + ".png";
        figure;
        plot(t, x_data);
        hold on;
    
        padding_left = 0.1; 
        yLimits_left = ylim(gca);
        newMin_left = yLimits_left(1) - padding_left*(yLimits_left(2)-yLimits_left(1));
        newMax_left = yLimits_left(2) + padding_left*(yLimits_left(2)-yLimits_left(1));
        ylim(gca, [newMin_left, newMax_left]);
        
        xlabel('$t[s]$', 'fontsize', 18);
        y_label_str = "$x(t)$";
        ylabel(y_label_str, 'fontsize', 18);
        
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

        % Control signal 
        file_name = "images/extra_ex_u_sb=" + sb + "_" + names(i) + ".png";
        figure;
        plot(t, u_data);
        hold on;
    
        padding_left = 0.1; 
        yLimits_left = ylim(gca);
        newMin_left = yLimits_left(1) - padding_left*(yLimits_left(2)-yLimits_left(1));
        newMax_left = yLimits_left(2) + padding_left*(yLimits_left(2)-yLimits_left(1));
        ylim(gca, [newMin_left, newMax_left]);
        
        xlabel('$t[s]$', 'fontsize', 18);
        y_label_str = "$u(t)$";
        ylabel(y_label_str, 'fontsize', 18);
        
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
end