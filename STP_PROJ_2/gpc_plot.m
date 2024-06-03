

[y, u] = ex7_gpc(20, 3, 85, 5, 100, 100000, 4.1835, 0, 0.0, 200);
n = length(y);
% 1.61009
figure;
stairs(1:n, y);
hold on;
% stairs(1:n, u);

x0=10;
y0=10;
width=1280;
height=720;
set(gcf,'position',[x0,y0,width,height]);
grid(gca,'minor');
title('');