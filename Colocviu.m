% Colocviu FC 22 mai 2020
% Necula Bianca 315CA
clear; close all; clc;
m = 0.201; % masa in kg
t0 = 1; % timpul initial
tf = 101; % timpul final
N = 1000; % numarul momentelor
t=linspace(t0,tf,N);
dt=t(2)-t(1); % discretizarea timpului
f = 0.7 * tand(sqrt(t - 1)); % tand este folosit pentru a lucra in grade
a = f ./ m; % valoarea acceleratiei in toate momentele de timp
v = zeros(1, N); 
v(1) = 0; % viteza initiala deorece corpul pleaca din repaus
v(2) = a(1)*dt; % viteza din urmatorul moment de timp
for i = 3 : N  % aflarea recursiva a vitezei
  v(i) = v(i-1) + a(i-1) * dt; 
endfor
figure(1);  
plot(t, v, '-b'); % plottarea graficului vitezei in functie de timp
xlabel('t/s'); ylabel('viteza(m/s)');