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
ffactor = 0.5;
k_plane = pi/pitch;
N = 2;
search_re = linspace(77.3495,80,11);
search_im = linspace(-5,5,3);
search_re_width = ones(1,length(search_re)) * ...
                    (search_re(2) - search_re(1))/2;
search_im_width = ones(1,length(search_im)) * ...
                    (search_im(2) - search_im(1))/2;
search_re_N = ones(1,length(search_re)) * 200;
search_im_N = ones(1,length(search_im)) * 200;

[re, im] = find_band(chi, pitch, ffactor, k_plane, N, ...
                                        search_re, search_im, ...
                                        search_re_width, search_im_width, ...
                                        search_re_N, search_im_N)