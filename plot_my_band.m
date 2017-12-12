function plot_my_band(chi,pitch,ffactor,k_plane,Nsearch,N,Nplot,Nth_band, ...
                        search_re,search_im, ...
                        search_re_width,search_im_width, ...
                        search_re_N,search_im_N)
% PLOT_MY_BAND
% Searches for a valid omega value, then plots its E-field distribution
%
% Parameters:
% - chi: chi value in grating
% - pitch: length of periods in grating
% - ffactor: filling factor in grating
% - k_plane: k_plane value of interest
% - Nsearch: 2*Nsearch+1 Fourier terms will be used to search for the valid
%            omega values in the Green's Function matrix determinant
% - N: 2*N+1 Fourier components will be used to generate the Green's
%            function matrix to determine the Fourier components for
%            graphing
% - Nplot: Number of discrete x-values to use for plotting the E-field
% - Nth_band: NOT YET IMPLEMENTED; searches for the [Nth_band]th omega
%             solution, which should correspond to the nth band for
%             suitable search ranges
% - search_re: array of values to search around for omega's real solution
%              component
% - search_im: array of values to search around for omega's imaginary
%              solution component
% - search_re_width: array of corresponding distances around search_re
%                    values to search through in the mesh
% - search_im_width: array of corresponding distances around search_im
%                    values to search through in the mesh
% - search_re_N: array of corresponding index counts around each search_re
%                value for the meshing (Higher values = greater precision)
% - search_im_N: array of corresponding index counts around each search_im
%                value for the meshing (Higher values = greater precision)


[w_re,w_im] = find_band(chi, pitch, ffactor, k_plane, Nsearch, ...
                                        search_re, search_im, ...
                                        search_re_width, search_im_width, ...
                                        search_re_N, search_im_N);
if w_re == -1 && w_im == 0
    error('No valid omega values found using mesh-minimum')
end

M = Chi_matrix(chi, pitch, ffactor, k_plane, w_re, w_im, N);

vec = get_one_eig_vec(M, 2*N+1);

plot_fourier_terms(vec,N,pitch,k_plane,Nplot);