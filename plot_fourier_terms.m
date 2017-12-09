function plot_fourier_terms(vec,N,pitch,k_plane,N_points)


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