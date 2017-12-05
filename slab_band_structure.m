clear;

c = 299792458; % speed of light, m/s
epsilon_r = 11.68; %silicon permitivity
chi = epsilon_r - 1; 
pitch = 200; 
ffactor = 1;
N = 0;
k_plane = linspace(0, pi/pitch, 41);
set(0,'DefaultFigureWindowStyle','docked');

w2_1 = (-1+sqrt(1+16*pi^2*chi^2*ffactor^2*k_plane.^2))/(8*pi^2*chi^2*ffactor^2);
w2_2 = (-1-sqrt(1+16*pi^2*chi^2*ffactor^2*k_plane.^2))/(8*pi^2*chi^2*ffactor^2);
hold on
plot(k_plane,sqrt(w2_1),'linewidth',2);
%hold on;
%plot(k_plane,k_plane,'linewidth',2)
%plot(k_plane,sqrt(w2_2));
%legend('slab', 'light line');
xlabel('k');
ylabel('w/c')
set(gca, 'fontsize',20)