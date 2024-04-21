% Initial conditions
x_0 = [5 -1 3];
xo_0 = [0 0 0];
% x_0 = [0 0 0];
x_fin = [0 0 0];

t_0 = 0;
t_fin = 10;

A = [-21  -146  -336; 1     0     0; 0     1     0];
B = [1; 0; 0];
C = [1 7.5 12.5];
D = 0;

sb = -3;
s0 = -30;

k = acker(A, B, [sb sb sb]);
L = acker(A', C', [s0 s0 s0]);