
%Constants
epsilon_r = 11.68; %silicon permitivity
chi = epsilon_r - 1;

%Parameters
pitch = 200e-9;
ffactor = 0.5;
k_plane = 0.01;
matrix_N = 10;

N_X = 800; %X values are real omega
min_X = 0.009;
max_X = 0.014;
step_X = (max_X-min_X)/(N_X-1);

N_Y = 800; %Y values are complex omega
min_Y = -0.01;
max_Y = 0.01;
step_Y = (max_Y-min_Y)/(N_Y-1);

%Mesh
[X,Y] = meshgrid(min_X:step_X:max_X,min_Y:step_Y:max_Y);
X_val = min_X:step_X:max_X;
Y_val = min_Y:step_Y:max_Y;
Z = zeros(N_Y,N_X);

for i = 1:N_X
    for j = 1:N_Y
        
        Z(j,i) = Chi_matrix_deter_abs(chi, pitch, ffactor, k_plane, X_val(i), Y_val(j), matrix_N);
        
    end
end

figure;
surf(X,Y,Z, 'edgealpha', 0);
xlabel('X');
