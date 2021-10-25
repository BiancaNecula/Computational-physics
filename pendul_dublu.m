%pendul gravitational dublu (miscarea haotica)
clc; clear; close all;
g=9.80665; %N/kg
m1=1; m2=2; %kg; masele corpurilor
L1=0.8; L2=0.5; %m; lungimile tijelor 
theta10=-pi/2; theta20=5*pi/7; %rad; unghiurile initiale (intre -pi si pi)
v10=0; v20=0; %rad/s; vitezele unghiulare initiale
omega1=sqrt(g/L1); omega2=sqrt(g/L2); %pulsatii proprii individuale
T1=2*pi/omega1; T2=2*pi/omega2; %perioade proprii individuale
Tmax=max(T1,T2);
miu=1+m1/m2; r=L1/L2; %parametrii adimensionali
A11=miu*r; A22=1/r; %coeficientii diagonali principali constanti
t0=0; tf=5*Tmax; N=500;
t=linspace(t0,tf,N); dt=t(2)-t(1); %discretizarea timpului
theta1=zeros(1,N); theta2=theta1 %prealocare pt rapiditate
theta1(1)=theta10; theta2(1)=theta20; %conditii initiale
theta1(2)=theta1(1)+v10*dt; theta2(2)=theta2(1)+v20*dt;
for i=2:N-1
  dtheta=theta2(i)-theta1(i);
  A12=cos(dtheta); A21=A12;
  %vitezele unghiulare "curente" (theta derivat):
  v1=(theta1(i)-theta1(i-1))/dt; v2=(theta2(i)-theta2(i-1))/dt;
  % termenii liberi: 
  B1=sin(dtheta)*v2^2-miu*omega2^2*sin(theta1(i));
  B2=sin(-dtheta)*v1^2-omega1^2*sin(theta2(i));
  A=[A11 A12; A21 A22]; %matricea sistemului liniar (patratica de ord 2)
  B=[B1; B2];
  %A*E=B sistemul liniar E=A^(-1)*B
  E=A\B; %inv(A)*B - sintaxa Matlab alternativa
  eps1=E(1); eps2=E(2); %acceleratiile unghiulare
  theta1(i+1)=2*theta1(i)-theta1(i-1)+dt^2*eps1;
  theta2(i+1)=2*theta2(i)-theta2(i-1)+dt^2*eps2;
endfor
x1=L1*sin(theta1); y1=-L1*cos(theta1);
x2=x1+L2*sin(theta2); y2=y1-L2*cos(theta2);
figure(1); %vizualizarea dinamica a oscilatiilor
Ltot=L1+L2;
for i=1:N
  hold off;
  plot([0 x1(i)],[0 y1(i)],'-k'); %tija 1
  hold on;
  plot(x1(i),y1(i),'.r','MarkerSize',20); %corpul 1
  plot([x1(i) x2(i)],[y1(i) y2(i)],'-k'); %tija 2
  plot(x2(i),y2(i),'.b','MarkerSize',15); %corpul 2
  grid;
  axis([-Ltot Ltot -Ltot Ltot]); axis square;
  Film(i)=getframe; %getfame()
endfor
%figure(2);
%movie(Film,1,round(N/tf-t0))); 
