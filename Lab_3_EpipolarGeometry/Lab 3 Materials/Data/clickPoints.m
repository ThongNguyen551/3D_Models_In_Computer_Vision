function [A1,A2] = clickPoints(I1,I2,N)
% I : Image
% N : Number of Points

figure(1);
subplot(1,2,1)
imshow(I1);hold on;
subplot(1,2,2)
imshow(I2);hold on;

A1 = ones(2,N);
A2 = ones(2,N);

k = 1;
while (k <= N)
    [xi,yi] = ginput(1); % Click a point on the image
    A1(1,k) = xi;
    A1(2,k) = yi;
    plot(xi, yi,'g+');
    [xi,yi] = ginput(1); % Click a point on the image
    A2(1,k) = xi;
    A2(2,k) = yi;
    plot(xi, yi,'r+');
    k = k+1;
end
