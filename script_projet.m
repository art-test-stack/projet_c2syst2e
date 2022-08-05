%Variables%


Rs = 0.6 ; %Résistance du stator (Ohm)
Ld = 0.0014 ; %Inductance linéaire du stator selon l'axe d (H)
Lq = 0.0028 ; %Inductance linéaire du stator selon l'axe q (H)
w_ri = 400 ; %vitesse angulaire du rotor
phi_f = 0.12 ; %flux d'aimant permanent (Wb)
P= 4 ; %nombre de paire de pôle
teta= 0 ; %angle de charge (position de rotor) définie par intégrale sur [0 , t] de w*dt
Vm = 120 ; %amplitude des signaux d'entrée ou tension nominale(V)
J=11*10^-5 ; %Moment d'inertie(N.m.s²/rad)
f= 14*10^-5 ; %(sans unité)
Cr = 5; % (N.m)

% Découplage

%Kpd = Ld*Kid/Rs;
%tau_d = Rs / Kid ;
trd = 3*Rs/Ld ; %3*tau_d ;
trq = 3*Rs/Lq ; 
Kid = 3*Rs/trd ;
Kiq = 3*Rs/trq ;

Kpd = 3*Ld/trd;
Kpq = 3*Lq/trq;

tr2 = 3*f/J ;
KiO = 3*f/tr2 ;
KpO = 3*J/tr2*10^8;
%{
T=2/3*[ cos(teta) cos(teta-2*pi/3) cos(teta+2*pi/3) ;
        sin(teta) sin(teta-2*pi/3) sin(teta+2*pi/3) ;
        1/2         1/2                 1/2         ;];

A = [ -Rs/Ld we*Lq/Ld 0 -we*Lq0/Ld ;
      -we*Ld/Lq -Rs/Lq we*Ld0/Lq 0 ;
      0 0 0 0;
      0 0 0 0;];
B = [ 1/Ld 0 ;
      0 1/Lq ;
      0 0;
      0 0;];
%}

A = [ -Rs/Ld w_ri*Lq/Ld 0 -w_ri*Lq/Ld ;
      -w_ri*Ld/Lq -Rs/Lq w_ri*Ld/Lq 0;
      0 0 0 0;
      0 0 0 0;];
B = [ 1/Ld 0 ;
      0 1/Lq ;
      0 0;
      0 0;];
C = [1 0 0 0 ; 
    0 1 0 0;];

v = [ 0 -w_ri*phi_f/Lq 0 0]';

R = [1 0 0 0;
    0 1 0 0;
    0 0 1 0;
    0 0 0 1;];
Q = R;
K = (P^-1)*C'*R^-1;

