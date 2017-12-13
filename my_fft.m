function [ampl, freq] = my_fft(y, dt, plots)

freq = 2*pi/dt*(0:(length(y)-1))/length(y);
ampl = fft(y);

if plots ~= 0
    figure
    plot(freq,real(ampl))
    hold on
    plot(freq,imag(ampl))
    xlabel('Frequency (Rad/s)')
    ylabel('Amplitude')
    legend('Real Amplitude', 'Imag Amplitude')
    hold off
end