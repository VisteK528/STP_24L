function [y, u] = ex7_gpc(N, Nu, D, lambda, iterations)

% Horizons
[c, b] = diff_eq_coeffs;

% Step response for given dynamic horizon
% s = zeros(D, 1);
% for j=1:D
%     b_sum = 0;
%     for i=1:min(j-1, 2)
%         b_sum = b_sum + b(3-i)*s(j-i);
%     end
%     s(j) = sum(c(1:min(j, 2))) + b_sum; 
% end
s = ex4_step_response(D+1);
s = s(2:end);


% Fill M matrix
M = zeros(N, Nu);
for i=1:Nu
    M(i:end,i)=s(1:N-i + 1);
end


% Obliczanie parametrów regulatora
I = eye(Nu);
K = ((M'*M+lambda*I)^(-1))*M';



% Main loop
y = zeros(iterations, 1);
u = zeros(iterations, 1);

y_zad(1:10) = 0;
y_zad(10:iterations) = 1;
y(1:12) = 0;


uk = 0;
d(1:iterations) = 0;
d(100:end) = 0.1;
y_0(1:N+2) = 0;


for k=13:iterations
    y(k) = y(k-2)*b(2) + y(k-1)*b(1) + u(k-12)*c(2) + u(k-11)*c(1)+d(k);

    y_0(1) = y(k-2);
    y_0(2) = y(k-1);

    % Model prediction
    for i=1:N
        if 12 - i > 0
            y_0(i+2) = y_0(i)*b(2) + y_0(i+1)*b(1) + u(k+i-13)*c(2) + u(k+i-12)*c(1)+d(k);
        else
            y_0(i+2) = y_0(i)*b(2) + y_0(i+1)*b(1) + u(k-1)*c(2) + u(k-1)*c(1)+d(k);
        end
    end
    y_zad_pred = ones(N, 1) * y_zad(k);

    deltauk = K*(y_zad_pred - y_0(3:end)');
    uk = uk + deltauk(1);
    u(k) = uk;
end
end


