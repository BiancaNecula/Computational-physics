% Miscarea unui proiectil cu frecare fluida;
clear;close all;clc;
g=9.81; % metru/secunda^2;
m=5; % kilogram;
v0=2000; % metru/secunda; 
b1=m*g/v0; % coeficient de frecare liniara
b2=m*g/v0^2; % coeficient de frecare patratica
t0=0; % secunda;
N=1000; % numarul momentelor
bataie=10000; 
err=100;
for alpha0 = 0:0.1:90
  
    tf=2*v0*sind(alpha0)/g; % supraestimare initiala a timpului total din Ff = 0;
    t=linspace(t0,tf,N);
    dt=t(2)-t(1); % pasul de timp
    vx=zeros(1,N);
    vy=vx;
    x=zeros(1,N);
    y=x;
    vx(1)=v0*cosd(alpha0);
    vy(1)=v0*sind(alpha0);
    for i=1:1:N-1
        aux=dt/m*(b1+b2*sqrt(vx(i)^2+vy(i)^2));
        vx(i+1)=vx(i)*(1 - aux);
        vy(i+1)=vy(i)*(1-aux)-g*dt;
        x(i+1)= x(i)+vx(i)*dt;
        y(i+1)= y(i)+vy(i)*dt;
        if y(i+1)<0, break; end; % a facut boom
    end;
    valid=1:i; % subsir cu valori fizice valide
    vx=vx(valid); vy=vy(valid); x=x(valid); y=y(valid); t=t(valid); % scurtare 
    if ((x(i)>bataie-err) && (x(i)<bataie+err)), break; end; % a facut boom destul de aproape
end;
figure(1); % deschide prima fereastra grafica
plot(t, vx, '-r',t,vy,'-b');
xlabel('t(s)'); ylabel('viteza(m/s)');
title('Legile vitezelor pe x si y'); grid;
legend('viteza orizontala','viteza verticala');
figure(2);
set(2,'Position',[50,50,700,350])
plot(x/1e3,y/1e3,'-k','LineWidth',1);
axis equal;
axis ([0,35,0,15])
xlabel('x(km)'); ylabel('y(km)');
title('Traiectoria'); grid;
ymax=max(y)/1e3;
if(abs(x(i)-bataie)>err || abs(x(i)-bataie)>err)
afis=['eroare: proeictilul nu a ajuns la tinta'];
disp(afis)
else 
afis=['Unghiul alpha0 este: ',num2str(alpha0),' grade'];
disp(afis);
%afis=['Eroarea este: ',num2str(x(i)-bataie),' metri'];
%disp(afis);
end;