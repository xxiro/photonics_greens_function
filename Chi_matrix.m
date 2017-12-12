function M = Chi_matrix(chi, pitch, ffactor, k_plane, w_re, w_im, N)
% CHI_MATRIX
% Returns the Green's function matrix for a periodic grating

w = w_re + 1i*w_im;

if N ~=0
    M = zeros(2*N+1);
    
    for i = 0:1:2*N
        for j = 0:1:2*N
            M(i+1,j+1) = 2*pi*1i*w^2*chi*(chi_hat_n(i-j,ffactor)) / ...
                sqrt(w^2 - (k_plane + 2*pi*(i-N)/pitch )^2 );
        end
    end
            

else
    
    M = 2*pi*1i*w^2*chi*ffactor/(sqrt(w^2-k_plane^2));
   
end

end