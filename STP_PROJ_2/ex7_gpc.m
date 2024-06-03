function [y, u] = ex7_gpc(N, Nu, D, lambda, start, kend, K_0, T_0, z_value, z_step)

[c, b] = diff_eq_coeffs;
s = ex4_step_response(start, N, D, c, b);
s = s(start+1:end);


% Fill M matrix
M = zeros(N, Nu);
for i=1:Nu
    M(i:end,i)=s(1:N-i + 1);
end


% Obliczanie parametrów regulatora
I = eye(Nu);
K = ((M'*M+lambda*I)^(-1))*M';


% Main loop
y = zeros(kend, 1);
u = zeros(kend, 1);
z = zeros(kend, 1);

y_zad(1:start) = 0;
y_zad(start:kend) = 1;


uk = 0;
z(z_step:end) = z_value;
ypred(1:N+2) = 0;

for k=start:kend
    y(k) = y(k-2)*b(2) + y(k-1)*b(1) + K_0*(u(k-12-T_0)*c(2) + u(k-11-T_0)*c(1)+z(k));
    d = y(k) - (y(k-2)*b(2) + y(k-1)*b(1) +u(k-12)*c(2) + u(k-11)*c(1));

    ypred(1) = y(k-1);
    ypred(2) = y(k);
    % Model prediction
    for i=1:N
        if (11 - i) == 0
            ypred(i+2) = ypred(i)*b(2) + ypred(i+1)*b(1) + u(k+i-12)*c(2) + u(k-1)*c(1) + d;
        elseif 11 - i > 0
            ypred(i+2) = ypred(i)*b(2) + ypred(i+1)*b(1) + u(k+i-12)*c(2) + u(k+i-11)*c(1) + d;
        else
            ypred(i+2) = ypred(i)*b(2) + ypred(i+1)*b(1) + u(k-1)*c(2) + u(k-1)*c(1) + d;
        end
    end

    y_zad_pred = ones(N, 1) * y_zad(k);
    deltauk = K*(y_zad_pred - ypred(3:end)');
    uk = uk + deltauk(1);
    u(k) = uk;
end
end


