% Simulation setup
x_0 = [5 -1 3];
xo_0 = [10 20 30];
x_fin = [0 0 0];

t_0 = 0;
t_fin = 6;

A = [-21  -146  -336; 1     0     0; 0     1     0];
B = [1; 0; 0];
C = [1 7.5 12.5];
D = 0;

Ar = [A zeros(3, 1); -C 0];
Br = [B; 0];

sb = -5;
Kr = acker(Ar, Br, [sb sb sb sb]);
k = Kr(1:3);
Ke = Kr(4);

% sb = -6.9;
% k = acker(A, B, [sb sb sb]);