load("stp_proj2_data.mat")
Gc = tf([Ko], [T1*T2 T1 + T2 1],'InputDelay', To);

Kk = 0.661505;
Tk = 19.6;

% PID Parameters
Kp = 0.6*Kk; Ti = 0.5*Tk; Td = 0.12*Tk;

R = pidstd(Kp, Ti, Td);

length = 100;
step_time = 10;
y_zad = 1;
u = 0;
y = zeros(length);
k_table = zeros(length);

sys_cl = feedback(R*Gc, 1);
step(sys_cl, 70);