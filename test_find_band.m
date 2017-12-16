%%% Quick and dirty second band test
% chi = 10.68;
% pitch = 2.0e-5;
% ffactor = 0.5;
% k_plane = 0;
% N = 2;
% search_re = linspace(78,90,11);
% search_im = linspace(-5,5,11);
% search_re_width = ones(1,length(search_re)) * ...
%                     (search_re(2) - search_re(1))/2;
% search_im_width = ones(1,length(search_im)) * ...
%                     (search_im(2) - search_im(1))/2;
% search_re_N = ones(1,length(search_re)) * 200;
% search_im_N = ones(1,length(search_im)) * 200;

chi = 10.68;
pitch = 2.0e-5;
ffactor = 0.9;
k_plane = pi/pitch/8;
N = 4;
% search_re = linspace(62,87,11);
search_re = 104.6;
% search_im = linspace(-5,5,3);
search_im = 0;
% search_re_width = ones(1,length(search_re)) * ...
%                     (search_re(2) - search_re(1))/2;
search_re_width = 0.6;
% search_im_width = ones(1,length(search_im)) * ...
%                     (search_im(2) - search_im(1))/2;
search_im_width = 0.00000005;
search_re_N = ones(1,length(search_re)) * 200;
search_im_N = ones(1,length(search_im)) * 200;
re_threshold = 1e-11;
im_threshold = 1e-11;
plots = 2;
recursions_remaining = 6;
tic;
[re, im] = find_band(chi, pitch, ffactor, k_plane, N, plots, ...
                                        search_re, search_im, ...
                                        search_re_width, search_im_width, ...
                                        search_re_N, search_im_N)
toc;

tic;
[r_re,r_im] = recursive_find_band(chi, pitch, ffactor, k_plane, N, ...
                                        plots, ...
                                        search_re, search_im, ...
                                        search_re_width, search_im_width, ...
                                        search_re_N, search_im_N, ...
                                        re_threshold, im_threshold, ...
                                        recursions_remaining)
toc;
