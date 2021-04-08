% Code développé par Cécile Barat - Mise à jour 1/04/2009
% Implantation de la méthode de calibrage de Tsai
% Entrées : 
% pts2d : matrice de points image 2D de taille 2 * N
% pts3d : matrice de points image 3D de taille 3 * N correspondants aux
% points 2D
% Sorties :
% K : matrice de paramètres intrinsèques
% RT : matrice de paramètres extrinsèques

function [K,RT]=calibTSAI(pts2d,pts3d,N,u0,v0)

%% Recentrage des points 2D sur l'image

% pas obligatoire (ne pas mettre u0, v0 dans la matrice si omis)
for j=1:N
    pts2d(1,j)=pts2d(1,j)-u0;
    pts2d(2,j)=pts2d(2,j)-v0;
end


%% Calibrage à partir des correspondances de points

for j=1:N
    A(j,1)=pts2d(1,j)*pts3d(1,j);
    A(j,2)=pts2d(1,j)*pts3d(2,j);
    A(j,3)=pts2d(1,j)*pts3d(3,j);
    A(j,4)=pts2d(1,j);
    A(j,5)=-pts2d(2,j)*pts3d(1,j);
    A(j,6)=-pts2d(2,j)*pts3d(2,j);
    A(j,7)=-pts2d(2,j)*pts3d(3,j);
    A(j,8)=-pts2d(2,j);
end

%% Résolution du système Av=0
[U,S,V] = svd(A);

% La solution correspond à la colonne de V associée à la seule valeur
% propre nulle (ou la plus proche de 0)
% Vecteur de solutions :
 v=V(:,8);
 
 
 %% Résolution des paramètres : 
% module du facteur d'échelle 
 modFech = sqrt(v(1)^2+v(2)^2+v(3)^2);
 
 % coefficient alpha 
if modFech~=0
 alpha = sqrt(v(5)^2+v(6)^2+v(7)^2)/modFech;
end

% détermination du signe de Fech
% On prend le premier point 
 r11=v(5)/(modFech*alpha);
 r12=v(6)/(modFech*alpha);
 r13=v(7)/(modFech*alpha);
 r21=v(1)/modFech;
 r22=v(2)/modFech;
 r23=v(3)/modFech;
 Tx=v(8)/(alpha*modFech);
 Ty=v(4)/modFech;
 
 % Détermination du signe de modFech (on étudie le signe de x par X. Les 2 éléments doivent être de même signe.)
 val=pts2d(1,1)*(r11*pts3d(1,1) + r12*pts3d(2,1) + r13*pts3d(3,1) + Tx);
 
 
 if val>0
    r11=-r11;
    r12=-r12;
    r13=-r13;
    r21=-r21;
    r22=-r22;
    r23=-r23;
    Tx=-Tx;
    Ty=-Ty;
 end

 %estimation de la 3eme ligne de la matrice de rotation
 r31=r12*r23-r13*r22;
 r32=r13*r21-r11*r23;
 r33=r11*r22-r12*r21;
 
 % correction de l'orthogonalité de la matrice
 R=[r11 r12 r13
     r21 r22 r23
     r31 r32 r33];
 [U2,D,V2] = svd(R) ;
 % on transforme la matrice diagonale en matrice identité
 D(1,1)=1;
 D(2,2)=1;
 D(3,3)=1;
 R=U2*D*V2';
 r11=R(1,1);
 r12=R(1,2);
 r13=R(1,3);
 r21=R(2,1);
 r22=R(2,2);
 r23=R(2,3);
 r31=R(3,1);
 r32=R(3,2);
 r33=R(3,3);
 clear A;


for j=1:N
    A(j,1)=pts2d(1,j);
    A(j,2)=-(r11*pts3d(1,j)+r12*pts3d(2,j)+r13*pts3d(3,j)+Tx);
    b(j,1)=-pts2d(1,j)*(r31*pts3d(1,j)+r32*pts3d(2,j)+r33*pts3d(3,j));
end

s=inv(A'*A)*A'*b;

Tz=s(1);

% Matrice de calibrage
fx=s(2);
fy=s(2)/alpha;
K = [fx 0 u0 0
0 fy v0 0
0 0 1 0];

RT=[r11 r12 r13 Tx
    r21 r22 r23 Ty
    r31 r32 r33 Tz
    0 0 0 1];
% P = K*RT; % matrice de projection finale
