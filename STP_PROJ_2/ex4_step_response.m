function [y, iterations] = ex4_step_response(dynamic_horizon)
y = zeros(dynamic_horizon, 1);
u = zeros(dynamic_horizon, 1);
iterations = zeros(dynamic_horizon, 1);

u(1:dynamic_horizon) = 1;
y(1:12) = 0;

[c, b] = diff_eq_coeffs;
for k=13:dynamic_horizon
    y(k) = y(k-2)*b(2) + y(k-1)*b(1) + u(k-12)*c(2) + u(k-11)*c(1);
    iterations(k) = k;
end
end