function [y] = ex4_step_response(kstart, N, D, c, b)
    y = zeros(kstart+N+D, 1);
    u = zeros(kstart+N+D, 1);
    u(kstart:end) = 1;
    for k=kstart:kstart+N+D
        y(k) = y(k-2)*b(2) + y(k-1)*b(1) + u(k-12)*c(2) + u(k-11)*c(1);
    end
end