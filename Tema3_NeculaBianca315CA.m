% Necula Bianca 315CA Tema 3
clear; close all; clc;
M=0.1; % masa unui oscilator
K=1000; % constanta elastica 
P=500; % numarul momentelor din discretizarea timpului
N=50; % numarul oscilatorilor (numarul elementelor de pozitie)
L=1; % lungimea sirului de oscilatori
m=M*ones(1,N);
k=K*ones(1,N);
t0=0;
A=1; % amplitudinea
T0=2*pi*sqrt(M/K); % perioada proprie 
tf=10*T0; %timpul final
t=linspace(t0,tf,P) % discretizarea timpului
dt=t(2)-t(1); % pasul de timp
eta_trecut=zeros(1,N); 
eta_prezent=zeros(1,N); 
eta_prezent(t<T0)=A*sin(8*pi*t(t<T0)/T0); % eta inittial la momentul 1 de timp 
eta_viitor=zeros(1,N); 
u=zeros(1,N); %viteza initiala
u(t<T0)=2*pi*t(t<T0)*A.*cos(2*pi*t(t<T0)/T0) % viteza initiala este derivata lui eta initial in functie de timp
eta_s=zeros(1,P); 
eta_d=zeros(1,P); 
dx=L./N; % distanta dintre doi oscilatori
figure(1);
for i=2:P-1 % ciclul temporal
    hold off;
    plot(1:N,eta_prezent,'-k'); hold on;
    xlabel('Pozitia'); ylabel('Functia de unda'); grid; 
    axis([0 N -A +A]);
    Film(i)=getframe;
    eta_s(1)=dx; % eta la capatul din stanga
    eta_d(N)=L-dx; %eta la capatul din dreapta
    for j=2:N-1
        eta_viitor(j)=eta_prezent(j)+u(j)*dt+dt^2/m(j)*...
        (k(j)*(eta_prezent(j+1)-eta_prezent(j))+k(j-1)*(eta_prezent(j-1)-eta_prezent(j)));
    end;
    eta_viitor(1)=eta_prezent(1)+u(1)*dt+dt^2/m(1)*...
        (k(1)*(eta_prezent(2)-eta_prezent(1))+K*(eta_s(i)-eta_prezent(1)));
    eta_viitor(N)=eta_prezent(N)+u(N)*dt+dt^2/m(N)*...
        (k(N)*(eta_d(i)-eta_prezent(N))+k(N-1)*(eta_prezent(N-1)-eta_prezent(N)));
    eta_trecut=eta_prezent; eta_prezent=eta_viitor; 
    % am modificat in relatii (eta_prezent(j) - eta_trecut(j))/dt ca fiind derivata lui eta, adica viteza
    
end;