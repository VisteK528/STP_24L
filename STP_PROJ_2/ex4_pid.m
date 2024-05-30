clear;
load("stp_proj2_data.mat")

% Digital PID parameters
Kk = 0.661505;
Tk = 19.6;
[r2, r1, r0] = discrete_pid_parameters(Kk, Tk, Tp);

% General settings
kk = 200;
yzad(1:9) = 0;
yzad(10:kk) = 1;
u(1:12) = 0;
y(1:12) = 0;
e(1:12) = 0;

[c, b] = diff_eq_coeffs;
for k=13:kk
    y(k) = y(k-2)*b(2) + y(k-1)*b(1) + u(k-12)*c(2) + u(k-11)*c(1);

    e(k) = yzad(k) - y(k);

    u(k) = r2*e(k-2) + r1*e(k-1) + r0*e(k) + u(k-1);
end

figure;
shape = size(y);
len = shape(2);
stairs((1:len)*Tp, u);
title("u");

figure;
%stairs(yzad);
%hold on;
stairs((1:len)*Tp, y);
title("y");


