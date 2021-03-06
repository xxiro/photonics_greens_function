function [w_re,w_im] = recursive_find_band(chi, pitch, ffactor, k_plane, N, ...
                                        plots, ...
                                        search_re, search_im, ...
                                        search_re_width, search_im_width, ...
                                        search_re_N, search_im_N, ...
                                        re_threshold, im_threshold, ...
                                        recursions_remaining)

%Update remaining recursions
recursions_remaining = recursions_remaining - 1;
% Threshold testing delta meshing values
d_re = abs(search_re_width(1) / (search_re_N(1)-1));
d_im = abs(search_im_width(1) / (search_im_N(1)-1));

if (plots == 2 || plots == 1) && ...
        (recursions_remaining == 0 || (d_re < re_threshold && d_im < im_threshold))
    [w_re, w_im] = find_band(chi, pitch, ffactor, k_plane, N, plots, ...
        search_re, search_im, ...
        search_re_width, search_im_width, ...
        search_re_N, search_im_N);
else
    [w_re, w_im] = find_band(chi, pitch, ffactor, k_plane, N, 0, ...
        search_re, search_im, ...
        search_re_width, search_im_width, ...
        search_re_N, search_im_N);
end

% No valid points found
if w_re == -1 && w_im == 0
    return;
end



% No more recursions or accuracy threshold reached
if recursions_remaining < 1 || ...
        (d_re < re_threshold && ...
        d_im < im_threshold)
    return;
end

% Another recursion it is!

% Next recursion search center values:
new_search_re = w_re;
new_search_im = w_im;
if d_re > re_threshold
    new_search_re_width = 4*d_re;
else
    new_search_re_width = search_re_width;
end
if d_im > im_threshold
    new_search_im_width = 4*d_im;
else
    new_search_im_width = search_im_width;
end

[w_re,w_im] = recursive_find_band(chi, pitch, ffactor, k_plane, N, ...
                                        plots, ...
                                        new_search_re, new_search_im, ...
                                        new_search_re_width, new_search_im_width, ...
                                        search_re_N, search_im_N, ...
                                        re_threshold, im_threshold, ...
                                        recursions_remaining);

end