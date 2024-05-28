% Difference quation parameters
c12 = 0.03641;
c11 = 0.04144;
b2 = -0.6782;
b1 = 1.655;

% Horizons
N = 75;
Nu = 75;
D = 75;

% Step response for given dynamic horizon
s = ex4_step_response(D);

% Fill M matrix
M = zeros(N, Nu);
for i=1:N
    for j=i:Nu
        M(j, i) = s(1+j-i);
    end
end

% Fill MP matrix
MP = zeros(N, D-1);
for i = 1:D-1
    for j = i+1:N+i
        if j < D    
            MP(j-i, i) = s(j) - s(i);
        else
            MP(j-i, i) = s(D) - s(i);
        end
    end
end

% Obliczanie parametrów regulatora
lambda = 1;

I = eye(Nu);
K = ((M'*M+lambda*I)^-1)*M';
Ku = K(1,:)*MP;
Ke = sum(K(1, :));

% Main loop
iterations = 200;
u(1:iterations) = 0;
y_zad(1:10) = 0;
y_zad(10:iterations) = 1;
y(1:12) = 0;
e(1:12) = 0;
deltaupk = zeros(D-1, 1);
uk = 0;

for k=13:iterations
    y(k) = y(k-2)*b2 + y(k-1)*b1 + u(k-12)*c12 + u(k-11)*c11;

    ek = y_zad(k) - y(k);

    deltauk = Ke*ek-Ku*deltaupk;

    for n=D-1:-1:2
        deltaupk(n) = deltaupk(n-1);
    end
    deltaupk(1) = deltauk;
    uk = uk + deltaupk(1);
    u(k) = uk;
end

figure;
stairs(1:iterations, y);


