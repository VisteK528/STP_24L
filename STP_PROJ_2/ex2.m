c12 = 0.03641;
c11 = 0.04144;
b2 = -0.6782;
b1 = 1.655;


kk = 120;


y = zeros(kk);
u = zeros(kk);
k_table = zeros(kk);

u(1:9) = 0;
u(10:kk) = 1;
y(1:12) = 0;

for k=13:kk
    y(k) = y(k-2)*b2 + y(k-1)*b1 + u(k-12)*c12 + u(k-11)*c11;
    k_table(k) = k;
end


figure;
stairs(k_table, y);

