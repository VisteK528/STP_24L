syms s

% Numerical approach
A = [-21  -146  -336; 1     0     0; 0     1     0];
B = [1; 0; 0];
C = [1 7.5 12.5];
D = 0;

s_vec = [s^3; s^2; s; 1];
[NUM, DEN] = ss2tf(A, B, C, D);
NUM_fcn = NUM*s_vec;
DEN_fcn = DEN*s_vec;

disp("Transmitancja wyznaczona w sposób numeryczny");
disp(NUM_fcn/DEN_fcn);

% Symbolic approach

G = collect(C*inv(s*eye(3, 3)-A)*B + D);

disp("Transmitancja wyznaczona w sposób symboliczny");
disp(G);
