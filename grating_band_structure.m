%clear;

%Constants
c = 299792458; % speed of light, m/s
epsilon_r = 11.68; %silicon permitivity
chi = epsilon_r - 1;

%Parameters
pitch = 200e-9; 
ffactor = 0.5;
N = 5;
k_plane = linspace(0, 1000, 441);
options = optimset('MaxIter', 400);%,'PlotFcns',@optimplotfval);
result = [];

w2_1 = (-1+sqrt(1+16*pi^2*chi^2*ffactor^2*k_plane.^2))/(8*pi^2*chi^2*ffactor^2);

for i = 1:length(k_plane)
    
    w_re = w2_1(i)- 0.00001i;
    w_im = 0;
    % deter_abs = @(w)abs(det(Chi_matrix(chi, pitch, ffactor, k_plane(i), w(1), w(2), N)...
    %     -eye(N)));
    k_plane_p = k_plane(i);
    f = @(w)(Chi_matrix_deter_abs(chi, pitch, ffactor, k_plane_p, w(1), w(2), N));
    [w, fval] = fminunc(f, [w_re, w_im],options);
    %M = Chi_matrix(chi, pitch, ffactor, k_plane, w_re, w_im, N);
    result(i,1) = w(1); 
    result(i,2) = w(2);
    result(i,3) = fval;
end
% 
figure;
plot(k_plane, result(:,1),'linewidth',3);
hold on;
plot(k_plane,sqrt(w2_1),'linewidth',2);
legend('fminunc','analytical');
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