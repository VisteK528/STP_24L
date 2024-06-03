function [y, u] = ex4_dmc(N, Nu, D, lambda, start, kend, K_0, ...
    T_0, z_value, z_step)
    % Step response for given dynamic horizon and predict horizon
    [c, b] = diff_eq_coeffs;
    s = ex4_step_response(start, N, D,c, b);
    s = s(start+1:end);
    
    
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
    
    % Regulator parameters
    I = eye(Nu);
    K = ((M'*M+lambda*I)^(-1))*M';
    Ku = K(1,:)*MP;
    Ke = sum(K(1, :));
    
    % Variables initialization
    y = zeros(kend, 1);
    u = zeros(kend, 1);
    z = zeros(kend, 1);
    deltauk_p = zeros(D-1, 1);
    
    y_zad(1:start) = 0;
    y_zad(start:kend) = 1;
    z(z_step:end) = z_value;
    
    % Main loop
    for k=start:kend
        % Generate process output
        y(k) = y(k-2)*b(2) + y(k-1)*b(1) + K_0*(u(k-12-T_0)*c(2) + ...
            u(k-11-T_0)*c(1) + z(k));

        % Compute error
        ek = y_zad(k) - y(k);

        % Compute deltau variable for given control horizon
        deltauk = Ke*ek-Ku*deltauk_p;
        
        % Back deltau window
        for n=D-1:-1:2
            deltauk_p(n) = deltauk_p(n-1);
        end
        
        % Delta u for time k
        deltauk_p(1) = deltauk;

        % Manipulate variable for time k
        u(k) = u(k-1) + deltauk;
    end
end

