close all; clear all; clc;

%% PART 1 - Construct necessary form of images

% a. Read the image
I=imread('chessboard00.png');
% b. Compute the image derivative Ix and Iy.
% c. Generate a Gaussian filter of size 9*9 and standard deviation 2.
% d. Apply the Gaussian filter to smooth the images Ix*Ix, Iy*Iy and Ix*Iy.
% e. Display the results


%% PART 2 - Compute Matrix E which contains for every point the value  
% of the smaller eigenvalue of auto correlation matrix M

% a. Compute E
	% Initialize E. Then, for each pixel, 
	% (1) build matrix M considering a window of size 3*3, 
	% (2) Compute eigenvalues of the matrix,
	% (3) save the smaller eigenvalue in E
% b. Display results
figure, imshow(mat2gray(E));


%% PART 3 - Compute Matrix R which contains for every point the cornerness score

% a. Compute R
	% Initialize R. Then, for each pixel, 
	% (1) build matrix M, 
	% (2) Compute the trace and the determinant of M,
	% (3) save the result of equation 3 in R
% b. Display results
figure, imshow(mat2gray(R));


%% PART 4 - Select for E and R the 81 most salient points.

% a. Write a function to obtain the 81 most salient points of E and R, 
% and their coordinates features(p_x, p_y)
% b. Display the selected points on top of the original image
figure; imshow(I); hold on; xlabel('Max 81 points');     
for i=1:size(features,2), 
	plot(features(i).p_x, features(i).p_y, 'r+'); 
end
hold off


%% PART 5 - Build  a  function  to  carry  out  non-maximal  suppression  for  E  and R
% Select the 81 most salient points using a non-maximal suppression of 11×11 pixels.

% a. Apply non maximal suppression with a window of 11*11
% b. Get the 81 most salient points and their coordinates, in the same way as part 4
% c. Display the selected points on top of the original image