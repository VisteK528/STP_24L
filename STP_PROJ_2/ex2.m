
kk = 120;
y = zeros(kk);
u = zeros(kk);
k_table = zeros(kk);

u(1:9) = 0;
u(10:kk) = 1;
y(1:12) = 0;

[c, b] = diff_eq_coeffs;
for k=13:kk
    y(k) = y(k-2)*b(2) + y(k-1)*b(1) + u(k-12)*c(2) + u(k-11)*c(1);
    k_table(k) = k;
end


figure;
stairs(k_table, y);

