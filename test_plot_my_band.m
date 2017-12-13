% epsilon_r = 11.68; % silicon permitivity
% chi = epsilon_r - 1; % Assuming uniform distribution where present
% pitch = 200e-7;
% ffactor = 0.5; % Filling Factors
% k_plane = 0;
% Nsearch = 16;
% Nplot = 200;
% N = 48;
% search_re = 80.9;
% search_im = 0.1;
% search_re_width = 1.0;
% search_im_width = 0.5;
% search_re_N = 300;
% search_im_N = 300;
% plot_my_band(chi,pitch,ffactor,k_plane,Nsearch,N,Nplot, ...
%     1, search_re, search_im, search_re_width,search_im_width, ...
%     search_re_N, search_im_N);

epsilon_r = 11.68; % silicon permitivity
chi = epsilon_r - 1; % Assuming uniform distribution where present
pitch = 200e-7;
ffactor = 0.3; % Filling Factors
k_plane = 0;
Nsearch = 12;
Nplot = 200;
N = 48;
search_re = 101.5;
search_im = 0;
search_re_width = 1;
search_im_width = 1;
search_re_N = 400;
search_im_N = 400;
plot_my_band(chi,pitch,ffactor,k_plane,Nsearch,Nplot,N, ...
    1, search_re, search_im, search_re_width,search_im_width, ...
    search_re_N, search_im_N);
