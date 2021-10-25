% Acesta este un comentariu
% Miscarea unui proiectil cu frecare fluida
clear; % sterge toate variabile din workspace
close all; % inchide toate ferestrele grafice
clc; % clear command window
g=9.81; % m/s^2; acceleratia gravitationala
m=1.2; % kg; masa proiectilului
v0=900; % m/s; viteza initiala
b1=m*g/v0; b2=m*g/v0^2; % coeficientii de frecare fluida
alpha0=40; % grade; unghi initial
t0=0; % s; momentul initial
tf=2*v0*sind(alpha0)/g; % supraestimare initiala, din problema Ff=0
N=1000; % numarul momentelor
% t=t0:deltat:tf; % progresie aritmetica cu precizarea ratiei
t=linspace(t0,tf,N); % progresie aritmetica cu precizarea lungimii sirului
dt=t(2)-t(1); % pasul de timp
vx=zeros(1,N); % prealocare pentru optimizarea ciclului
vy=vx;
x=zeros(1,N);
y=x;
vx(1)=v0*cosd(alpha0);
vy(1)=v0*sind(alpha0);
for i=1:N-1 % prima valoare : ratia : ultima valoare; ratia implicita 1
   aux=dt/m*(b1+b2*sqrt(vx(i)^2+vy(i)^2)); % ; inhiba ecoul/rezultatul
   vx(i+1)=vx(i)*(1-aux);
   vy(i+1)=vy(i)*(1-aux)-g*dt;
   x(i+1)=x(i)+vx(i)*dt;
   y(i+1)=y(i)+vy(i)*dt;
   if y(i+1)<0, break; end; % conditie de contact cu solul
end;
valid=1:i; % subsir cu semnificatie fizica
vx=vx(valid); vy=vy(valid); x=x(valid); y=y(valid); t=t(valid);
figure(1); % deschide fereastra grafica
plot(t,vx,'-r',t,vy,'-b');
xlabel('t/s'); ylabel('viteza(m/s)'); % etichete abscisa/ordonata
title('Legile vitezelor'); grid;
legend('viteza orizontala','viteza verticala');
figure(2);
set(2,'Position',[50,50,800,600]); % coordonate pixel stanga jos, lungime, inaltime
plot(x/1e3,y/1e3,'-k','LineWidth',2);
axis equal; % factor de scala comun pe x si y
axis([0 35 0 15]); % [xmin xmax ymin ymax]
xlabel('x/km'); ylabel('y/km'); % etichete abscisa/ordonata
title('Traiectoria'); grid;
ymax=max(y)/1e3;
afis=['Altitudinea maxima este: ',num2str(ymax),' km'];
disp(afis);