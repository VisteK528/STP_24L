function [c, b] = diff_eq_coeffs()
% Import data
load("stp_proj2_data.mat")

Gc = tf([Ko], [T1*T2 T1 + T2 1],'InputDelay', To);
[num, den] = tfdata(c2d(Gc, Tp, 'zoh'), 'v');

c = [num(2) num(3)];
b = [-den(2) -den(3)];
end

