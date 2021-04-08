function F=MatF(p1,p2)
% p1,p2 : vectors of coordinates ...x...

% initialisation
A = [];
N=8;

% Write a martix of homogeneous linear system Af=0
% ---> TODO <---
% Compute matrix for points corespondence
%     x1y1' x1y1' x1 y1x1' y1y1' y1 x1' y1' 1
%     .                                     .
% A = .                                     .
%     .                                     .
%     xmxm' xmym' xm ymxm' ymym' ym xm' ym' 1
for index = 1:1:N
    % Get coordinate of each point from 2 cameras
    x1 = p1(1,index); 
    y1 = p1(2,index);
    x2 = p2(1,index);
    y2 = p2(2,index);
    % Calculate each element in row of matrix A
    xm1xm2 = x1 * x2;
    xm1ym2 = x1 * y2; 
    xm1    = x1;
    ym1xm2 = y1 * x2;
    ym1ym2 = y1 * y2;
    ym1    = y1;
    xm2    = x2;
    ym2    = y2;
    temp = [xm1xm2 xm1ym2 xm1 ym1xm2 ym1ym2 ym1 xm2 ym2 1];
    % Join row by row into matrix A
    A = [A; temp];
end

% Solving the linear system for the estimate of F by SVD
% Ist step: Linear solution
[U,S,V] = svd(A)
Fest = reshape(V(:,end),3,3)

% 2nd step: Constraint enforcement
Fest=Fest';
[U,S,V] = svd(Fest);
F = U*diag([S(1,1) S(2,2) 0])*V';
