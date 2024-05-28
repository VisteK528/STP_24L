Ko = 3.4;
To = 5;
T1 = 1.7;
T2 = 5.31;
Tp = 0.5;

Gc = tf([Ko], [T1*T2 T1 + T2 1],'InputDelay', To);

% Kp = 0.6615;
% R = pidstd(Kp);
Kp = 0.3969;
Ti = 10;
Td = 2.4;
R = pidstd(Kp, Ti, Td);

length = 100;
step_time = 10;
y_zad = 1;
u = 0;
y = zeros(length);
k_table = zeros(length);

sys_cl = feedback(R*Gc, 1);
step(sys_cl);