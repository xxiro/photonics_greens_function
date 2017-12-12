
function [w_re, w_im] = find_band(chi, pitch, ffactor, k_plane, N, ...
                                        search_re, search_im, ...
                                        search_re_width, search_im_width, ...
                                        search_re_N, search_im_N)
% FIND_BAND  Finds the first valid omega values by searching iterative
%            meshes. Searches along the imag direction first for each real.
%
%  Parameters:
%  - chi: value of chi magnitude [double]
%  - pitch: pitch of grating [double]
%  - ffactor: filling factor of grating [double]
%  - k_plane: in-plane k-vector magnitude [double]
%  - N: 2*N+1 Fourier terms are used in determinant calculations [int]
%  - search_re: real values to center grid searches at [double array]
%  - search_im: imag values to center grid searches at [double array]
%  - search_re_width: corresponding array for total widths
%                     around search_re to mesh for [double array]
%  - search_im_width: corresponding array for total widths
%                     around search_im to mesh for [double array]
%  - search_re_N: corresponding array for real-axis granularity about 
%                 search_re values
%  - search_im_N: corresponding array for imag-axis granularity about 
%                 search_im values
% Returns:
% Real and imaginary components of omega or w_re=-1 and w_im=0 if no
% valid value is found.

w_re = -1;
w_im = 0;

if length(search_re) ~= length(search_re_width)
    error('Real search/width arrays do not match in length');
end

if length(search_im) ~= length(search_im_width)
    error('Real search arrays do not match in length');
end

%for search_re = 55:8:135
for i = 1:length(search_re)
    %for search_im = 0:8:80
    for j = 1:length(search_im)
        
        X_val = linspace(search_re(i) - search_re_width(i)/2, ...
                search_re(i) + search_re_width(i)/2, search_re_N(i));
        
        Y_val = linspace(search_im(j) - search_im_width(j)/2, ...
                search_im(j) + search_im_width(j)/2, search_im_N(j));
        
        Z = zeros(length(X_val),length(Y_val));
        
        for r = 1:length(X_val)
            parfor s = 1:length(Y_val)
                
                Z(s,r) = Chi_matrix_deter_abs(chi, pitch, ffactor, k_plane, X_val(r), Y_val(s), N);
                
            end
        end
        
        [M,Index] = min(Z(:));
        [I_row, I_col] = ind2sub(size(Z),Index); 
        
        if (I_row ~= 1) && (I_row ~= length(Y_val)) && ...
                (I_col ~= 1) && (I_col ~= length(X_val))
            
            w_re = X_val(I_col);
            w_im = Y_val(I_row);
            [X,Y] = meshgrid(X_val,Y_val);
            
            figure;
            surf(X,Y,log(Z),'edgealpha',0);
            
            return;
        end
    end
end

end % Of function
