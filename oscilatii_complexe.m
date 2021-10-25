% Oscilatii complexe, propagarea unidimensionala a undelor elastice - 27 martie
% se vizualizeaza reflexia si refractia
clear; close all; clc;
m1=0.1; m2=0.2; % kg; masele caracteristice portiunilor (1) si (2) ale "mediului" elastic
k1=1000; k2=350; % N/m; constantele elastice caracteristice zonelor (1) si (2)
P=500; % numarul momentelor din discretizarea timpului
N=100; % numarul oscilatorilor (numarul elementelor de pozitie)
N1=50; % numarul oscilatorilor din zona (1)
m=m2*ones(1,N);
m(1:N1)=m1; % definitia masei cu o discontinuitate
k=k2*ones(1,N);
k(1:N1)=k1; % definitia constantei eleastice cu o discontinuitate
t0=0;
T10=2*pi*sqrt(m1/k1); T20=2*pi*sqrt(m2/k2); % perioade proprii zonelor (1) si (2)
Tmax=max(T10,T20); tf=10*Tmax; % timpul final
t=linspace(t0,tf,P); % discretizarea timpului
dt=t(2)-t(1); % pasul de timp
eta_trecut=zeros(1,N); % conditie initiala pentru recurenta (primul moment)
eta_prezent=eta_trecut; % conditie initiala pentru recurenta (al doilea moment)
eta_viitor=zeros(1,N); % prealocarea elongatiei ca functie de pozitie
A=1; % cm; amplitudinea perturbatiei
eta_s=zeros(1,P);
eta_s(t<T10)=A*sin(t(t<T10)/T10); % conditia la capatul din stanga
eta_d=zeros(1,P); % conditia "rigida" la capatul din dreapta
figure(1);
for i=2:P-1 % ciclul temporal
    hold off;
    plot(1:N,eta_prezent,'-k'); hold on;
    xlabel('Pozitia'); ylabel('Functia de unda'); grid; 
    axis([0 N+1 -A +A]);
    Film(i)=getframe;
    for j=2:N-1
        eta_viitor(j)=2*eta_prezent(j)-eta_trecut(j)+dt^2/m(j)*...
        (k(j)*(eta_prezent(j+1)-eta_prezent(j))+k(j-1)*(eta_prezent(j-1)-eta_prezent(j)));
    end;
    eta_viitor(1)=2*eta_prezent(1)-eta_trecut(1)+dt^2/m(1)*...
        (k(1)*(eta_prezent(2)-eta_prezent(1))+k1*(eta_s(i)-eta_prezent(1)));
    eta_viitor(N)=2*eta_prezent(N)-eta_trecut(N)+dt^2/m(N)*...
        (k(N)*(eta_d(i)-eta_prezent(N))+k(N-1)*(eta_prezent(N-1)-eta_prezent(N)));
    % conditia de capat "liber": eta_viitor(N)=eta_viitor(N-1)
    eta_trecut=eta_prezent; eta_prezent=eta_viitor; % toate reprezinta siruri de N elemente
    
end;