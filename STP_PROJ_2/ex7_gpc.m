% Horizons
N = 30;
Nu = 10;
D = 120;

% Step response for given dynamic horizon
s = ex4_step_response(D);
s = s(2:end);
Nu = Nu - 1;
D = D - 1;
N = N - 1;


% Fill M matrix
M = zeros(N, Nu);
for i=1:Nu
    M(i:end,i)=s(1:N-i + 1);
end

% Fill MP matrix
MP = zeros(N, D-1);
for i = 1:N
    for j = 1:D-1
        if i+j <= D    
            MP(i, j) = s(i+j) - s(j);
        else
            MP(i, j) = s(D) - s(j);
        end
    end
end



% Obliczanie parametrów regulatora
lambda = 20;

I = eye(Nu);
K = ((M'*M+lambda*I)^(-1))*M';
Ku = K(1,:)*MP;
Ke = sum(K(1, :));

% Main loop
iterations = 200;
y = zeros(iterations, 1);
u = zeros(iterations, 1);
u(1:iterations) = 0;
y_zad(1:10) = 0;
y_zad(10:iterations) = 1;
y(1:12) = 0;
e(1:12) = 0;
deltauk_p = zeros(D-1, 1);
delta_u = zeros(D-1, 1);
uk = 0;

[c, b] = diff_eq_coeffs;
for k=13:iterations
    y(k) = y(k-2)*b(2) + y(k-1)*b(1) + u(k-12)*c(2) + u(k-11)*c(1);

    ek = y_zad(k) - y(k);

    deltauk = Ke*ek-Ku*deltauk_p;

    for n=D-1:-1:2
        deltauk_p(n) = deltauk_p(n-1);
    end
    deltauk_p(1) = deltauk;
    uk = uk + deltauk_p(1);
    u(k) = uk;
end

figure;
stairs((1:iterations)*0.5, y);
hold on;
stairs((1:iterations)*0.5, u);

x0=10;
y0=10;
width=1280;
height=720;
set(gcf,'position',[x0,y0,width,height]);
grid(gca,'minor');
title('');


