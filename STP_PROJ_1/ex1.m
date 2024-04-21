syms s
num_fcn = (s+2.5)*(s+5);
den_fcn = (s+6)*(s+7)*(s+8);

NUM = fliplr(double(coeffs(expand(num_fcn))));
DEN = fliplr(double(coeffs(expand(den_fcn))));

[A, B, C, D] = tf2ss(NUM, DEN);

syms x1 x2 x3 u
x = [x1; x2; x3];

dX = A*x + B*u;
y = C*x + D*u;