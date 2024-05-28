Ko = 3.4;
To = 5;
T1 = 1.7;
T2 = 5.31;
Tp = 0.5;

Gc = tf([Ko], [T1*T2 T1 + T2 1],'InputDelay', To);

Gd = c2d(Gc, Tp, 'zoh');

% Continuous transfer function gain
Gc_gain = dcgain(Gc);
Gd_gain = dcgain(Gd);

figure;
step(Gc, '-', Gd, '--');

