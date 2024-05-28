% Difference equation parameters
c12 = 0.03641;
c11 = 0.04144;
b2 = -0.6782;
b1 = 1.655;

% Digital PID parameters
r0 = 2.3119;
r1 = -4.1972;
r2 = 1.90512;

% General settings
kk = 200;
yzad(1:9) = 0;
yzad(10:kk) = 1;
u(1:12) = 0;
y(1:12) = 0;
e(1:12) = 0;

for k=13:kk
    y(k) = y(k-2)*b2 + y(k-1)*b1 + u(k-12)*c12 + u(k-11)*c11;

    e(k) = yzad(k) - y(k);

    u(k) = r2*e(k-2) + r1*e(k-1) + r0*e(k) + u(k-1);
end

figure;
stairs(u);
title("u");

figure;
%stairs(yzad);
%hold on;
stairs(y);
title("y");


