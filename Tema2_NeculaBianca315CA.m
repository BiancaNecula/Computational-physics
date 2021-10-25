%Tema2 Necula Bianca 315CA pendulul triplu
clc; clear; close all;
g=9.80665;
m1=1; m2=2; m3=3;
L1=0.8; L2=0.5; L3=0.2;
theta10=-pi/2; theta20=5*pi/7; theta30=pi/2;
v10=0; v20=0; v30=0;
omega1=sqrt(g/L1); omega2=sqrt(g/L2); omega3=sqrt(g/L3);
T1=2*pi/omega1; T2=2*pi/omega2; T3=2*pi/omega3;
Tmax=max(T1,max(T2,T3));
miu_a=1+m2/m3; miu_b=m1/m3;
r1=L2/L1; r2=L3/L1; r3=L3/L2;
A11=miu_b+miu_a; A22=r1*miu_a; A33=r2*r3;
t0=0; tf=5*Tmax; N=500;
t=linspace(t0,tf,N); dt=t(2)-t(1);
theta1=zeros(1,N); theta2=theta1; theta3=theta2;
theta1(1)=theta10; theta2(1)=theta20; theta3(1)=theta30;
theta1(2)=theta1(1)+v10*dt; theta2(2)=theta2(1)+v20*dt; theta3(2)=theta3(1)+v30*dt;
for i=2:N-1
  dtheta12=theta1(i)-theta2(i);
  dtheta13=theta1(i)-theta3(i);
  dtheta23=theta2(i)-theta3(i);
  A12=r1*miu_a*cos(dtheta12);
  A13=r2*cos(dtheta13);
  A21=miu_a*cos(dtheta12);
  A23=r1*r3*cos(dtheta23);
  A31=r3*cos(dtheta13);
  A32=r2*cos(dtheta23);
  %theta derivat:
  v1=(theta1(i)-theta1(i-1))/dt;
  v2=(theta2(i)-theta2(i-1))/dt;
  v3=(theta3(i)-theta3(i-1))/dt;
  % termenii liberi: 
  B1=-miu_a*r1*(v2^2)*sin(dtheta12)-r2*sin(dtheta13)*(v3^2)-(omega1^2)*sin(theta1(i))*(miu_a+miu_b);
  B2=-(omega2^2)*sin(theta2(i))*miu_a*r1 + miu_a*(v1^2)*sin(dtheta12) - r1*r3*sin(dtheta23)*(v3^2);
  B3=r3*(v1^2)*sin(dtheta13) + r2*sin(dtheta23)*(v2^2) - (omega3^2)*sin(theta3(i));
  A=[A11 A12 A13; A21 A22 A23; A31 A32 A33]; 
  B=[B1; B2; B3];
  E=A\B;
  eps1=E(1); eps2=E(2); eps3=E(3);
  theta1(i+1)=2*theta1(i)-theta1(i-1)+dt^2*eps1;
  theta2(i+1)=2*theta2(i)-theta2(i-1)+dt^2*eps2;
  theta3(i+1)=2*theta3(i)-theta3(i-1)+dt^2*eps3;
endfor 
x1=L1*sin(theta1); y1=-L1*cos(theta1);
x2=x1+L2*sin(theta2); y2=y1-L2*cos(theta2);
x3=x1+x2+L3*sin(theta3); y3=y1+y2-L3*cos(theta3);
figure(1); 
Ltot=L1+L2+L3;
for i=1:N
  hold off;
  plot([0 x1(i)],[0 y1(i)],'-k'); %tija 1
  hold on;
  plot(x1(i),y1(i),'.r','MarkerSize',20); %corpul 1
  plot([x1(i) x2(i)],[y1(i) y2(i)],'-k'); %tija 2
  plot(x2(i),y2(i),'.b','MarkerSize',15); %corpul 2
  plot([x2(i) x3(i)], [y2(i) y3(i)], '-k'); %tija3
  plot(x3(i),y3(i),'.b','MarkerSize', 5); %corpul3
  grid;
  axis([-Ltot Ltot -Ltot Ltot]); axis square;
  Film(i)=getframe();
endfor