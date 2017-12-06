%clear;

%Constants
c = 299792458; % speed of light, m/s
epsilon_r = 11.68; %silicon permitivity
chi = epsilon_r - 1;

%Parameters
pitch = 200e-9; 
ffactor = 0.5;
N = 2;
k_plane = linspace(0, 1000, 300);
options = optimset('MaxIter', 400);%,'PlotFcns',@optimplotfval);
mesh_N = 500;
result = [];

w2_1 = (-1+sqrt(1+16*pi^2*chi^2*ffactor^2*k_plane.^2))/(8*pi^2*chi^2*ffactor^2);


%%%Old optimization method
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

%%% New Optimization Method
Z = zeros(mesh_N);
N_X = mesh_N;
N_Y = mesh_N;
results = zeros(length(k_plane),3);
for i=1:length(k_plane)
    
    %Assign initial value
    if i > 2
        %w_re = results(i-1,1) + (results(i-1,1)-results(i-2,1))/ ...
        %    (k_plane(i-1)-k_plane(i-2)) * (k_plane(i)-k_plane(i-1));
        w_re = sqrt(w2_1(i));
    else
        w_re = sqrt(w2_1(i));
    end
    
    w_im = 0.0;
    
    %Get upper/lower bounds
    X_width = 0.3;
    Y_width = 0.3;
    X_val = linspace(w_re - X_width/2, w_re + X_width/2, N_X);
    Y_val = linspace(w_im - Y_width/2, w_im + Y_width/2, N_Y);
    
    %Assign matrix values
    parfor j = 1:N_X %X values
        for k = 1:N_Y %Y values
        
            Z(k,j) = Chi_matrix_deter_abs(chi, pitch, ffactor, k_plane(i), X_val(j), Y_val(k), N);
        
        end
    end
    
    [M,Index] = min(Z(:));
    [I_row, I_col] = ind2sub(size(Z),Index);
    
    results(i,1) = (w_re - X_width/2) + I_col * X_width/(N_X-1);
    results(i,2) = (w_im - Y_width/2) + I_row * Y_width/(N_Y-1);
    results(i,3) = Z(I_row,I_col);
    
    fprintf('i = %d / %d\n', i, length(k_plane));
    
end
% 
figure;
plot(k_plane, results(:,1),'linewidth',3);
hold on;
plot(k_plane,sqrt(w2_1),'linewidth',2);
%legend('fminunc','analytical');
legend('Mesh Optimization','Analytical');
xlabel('k');
ylabel('w/c');
set(gca,'fontsize',20)
% k_plane_part = 0.4*pi/pitch;
% 
% options = optimset('MaxIter', 400,'PlotFcns',@optimplotfval);
% w_re = 2*pi/pitch;
% w_im = 0;
% [w, fval] = fminunc(@(w)(Chi_matrix_deter_abs(chi, pitch, ffactor, k_plane_part, w(1), w(2), N)),...
%         [w_re, w_im],options),