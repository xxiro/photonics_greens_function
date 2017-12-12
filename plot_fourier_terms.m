function plot_fourier_terms(vec,N,pitch,k_plane,N_points)
% PLOT_FOURIER_TERMS
% Plots real and imaginary parts of fourier series from given coefficients
%
% Parameters:
% - vec: vector containing the Fourier components from the -Nth term to the
%        +Nth term in order
% - N: There are a total of 2*N+1 Fourier terms
% - pitch: The distance across which to plot the function
% - k_plane: The k_plane value for use in the Fourier expansion according
%            to the Green's function
% - N_Points: Number of discrete points to use along x-axis for graphing

x = 0:pitch/(N_points-1):pitch;
y = zeros(1,length(x));

for i=-N:N
    y = y + vec(i+N+1)*exp( 1i*(k_plane+2*pi*i/pitch).*x);
end

figure;
plot(x,real(y));
hold on
plot(x,imag(y));
legend('real','imag')
hold off;