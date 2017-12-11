%clear;

% Constants
c = 299792458; % speed of light, m/s
epsilon_r = 11.68; % silicon permitivity
chi = epsilon_r - 1; % Assuming uniform distribution where present

% Parameters
pitch = 200e-7;
ffactor = 0.001; % Filling Factors
N = 3; % 2*N + 1 total Fourier Components (N=0 for slab mode)
k_plane = linspace(0, pi/pitch, 400);
mesh_N = 800; % mesh_N*mesh_N sized grid used for peak search
X_mesh_width = 2; % Real omega mesh grid total width
Y_mesh_width = 2; % Imag omega mesh grid total width

% Analytic Slab Solution for comparison
w2_1 = (-1+sqrt(1+16*pi^2*chi^2*ffactor^2*k_plane.^2))/(8*pi^2*chi^2*ffactor^2);

%%% Current Optimization Method
Z = zeros(mesh_N);
N_X = mesh_N;
N_Y = mesh_N;
results = zeros(length(k_plane),3);

for i=1:length(k_plane)
    
    
    % Determine central values for meshing
    if i > 2
        w_re = results(i-1,1) + (results(i-1,1)-results(i-2,1))/ ...
            (k_plane(i-1)-k_plane(i-2)) * (k_plane(i)-k_plane(i-1));
        w_im = results(i-1,2) + (results(i-1,2)-results(i-2,2))/ ...
            (k_plane(i-1)-k_plane(i-2)) * (k_plane(i)-k_plane(i-1));
        
        % CONSIDER: Adding a second order correction term.
    else
        %w_re = sqrt(w2_1(i));
        %w_im = 0.0;
        w_re = 1;
        w_im = 0;
    end
    
    % Get upper/lower bounds
    X_val = linspace(w_re - X_mesh_width/2, w_re + X_mesh_width/2, N_X);
    Y_val = linspace(w_im - Y_mesh_width/2, w_im + Y_mesh_width/2, N_Y);
    
    
    % Assign matrix values
    parfor j = 1:N_X % X values
        for k = 1:N_Y % Y values
        
            Z(k,j) = Chi_matrix_deter_abs(chi, pitch, ffactor, k_plane(i), X_val(j), Y_val(k), N);
        
        end
    end
    
    [M,Index] = min(Z(:));
    [I_row, I_col] = ind2sub(size(Z),Index);
    
    results(i,1) = (w_re - X_mesh_width/2) + I_col * X_mesh_width/(N_X-1);
    results(i,2) = (w_im - Y_mesh_width/2) + I_row * Y_mesh_width/(N_Y-1);
    results(i,3) = Z(I_row,I_col);
    
    fprintf('i = %d / %d\n', i, length(k_plane));
    
end

figure;
plot(k_plane, results(:,1),'linewidth',3);
hold on;
plot(k_plane,sqrt(w2_1),'linewidth',2);
legend('Mesh Optimization','Analytical');
xlabel('k');
ylabel('w/c');
set(gca,'fontsize',20)


%%% Old optimization method
% options = optimset('MaxIter', 400);%,'PlotFcns',@optimplotfval);
% result = [];
% for i = 1:length(k_plane)
%     
%     w_re = w2_1(i)- 0.00001i;
%     w_im = 0;
%     % deter_abs = @(w)abs(det(Chi_matrix(chi, pitch, ffactor, k_plane(i), w(1), w(2), N)...
%     %     -eye(N)));
%     k_plane_p = k_plane(i);
%     f = @(w)(Chi_matrix_deter_abs(chi, pitch, ffactor, k_plane_p, w(1), w(2), N));
%     [w, fval] = fminunc(f, [w_re, w_im],options);
%     %M = Chi_matrix(chi, pitch, ffactor, k_plane, w_re, w_im, N);
%     result(i,1) = w(1); 
%     result(i,2) = w(2);
%     result(i,3) = fval;
% end

%legend('fminunc','analytical');
