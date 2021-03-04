import cv2 as cv
import numpy as np
import sys
from numpy import linalg as LA
import matplotlib.pyplot as plt
import matplotlib.image as mpimg

image_path = "/Users/Liam/Documents/COSIResources/Semester2-UJM/Computer Vision/3D_Models_In_Computer_Vision/Lab_1_HarrisCornerDetector/chessboard00.png"
des_path = "/Users/Liam/Documents/COSIResources/Semester2-UJM/Computer Vision/3D_Models_In_Computer_Vision/Lab_1_HarrisCornerDetector/"

# Display multiple images
def display_multiple_img(images, rows = 1, cols=1, des_path=None):
    figure, ax = plt.subplots(nrows=rows,ncols=cols)
    for ind,title in enumerate(images):
        ax.ravel()[ind].imshow(images[title],cmap="gray")
        ax.ravel()[ind].set_title(title)
        ax.ravel()[ind].set_axis_off()
    
    figure.savefig(des_path + "Harris_Corner_Process.png")
    plt.tight_layout()
    plt.show()

def image_derivative_and_smoothing(image, kernel_size, standard_deviation):
    # Compute image derivative
    # Ix = cv.Sobel(img,cv.CV_8U,1,0,ksize=5)
    # Iy = cv.Sobel(img,cv.CV_8U,0,1,ksize=5)
    Iy = np.gradient(image, axis=0)
    Ix = np.gradient(image, axis=1)
    IxIx = Ix * Ix
    IyIy = Iy * Iy
    IxIy = Ix * Iy

    # Apply Gaussian filter
    IxIx = cv.GaussianBlur(IxIx,kernel_size,standard_deviation)
    IyIy = cv.GaussianBlur(IyIy,kernel_size,standard_deviation)
    IxIy = cv.GaussianBlur(IxIy,kernel_size,standard_deviation)

    return IxIx, IyIy, IxIy

def compute_matrix(window_size, image, image_IxIx, image_IyIy, image_IxIy, k=0):
    offset = int(window_size/2)
    x_array = image.shape[0] - offset
    y_array = image.shape[1] - offset
    mtrx = []
    for y_pixel in range(offset, y_array):
        for x_pixel in range(offset, x_array):
            # Initialize sliding window
            start_x = x_pixel - offset
            end_x = x_pixel + offset +1
            start_y = y_pixel - offset
            end_y = y_pixel + offset +1

            # Build matrix M by using the chosen window size
            # Sum of squares of intensities of partial derevatives 
            windowIxx = image_IxIx[start_y : end_y, start_x : end_x]
            Sxx = windowIxx.sum()
            windowIxy = image_IxIy[start_y : end_y, start_x : end_x]
            Sxy = windowIxy.sum()
            windowIyy = image_IyIy[start_y : end_y, start_x : end_x]
            Syy = windowIyy.sum()
            
            if k > 0:
                # Calculate the determinant and trace of the matrix
                mtrx_M = np.array([[Sxx, Sxy], [Sxy, Syy]])
                det_M = LA.det(mtrx_M)
                trace_M = mtrx_M.trace()

                # Compute R
                R = det_M -  k*(trace_M**2)

                # Append R to matrix
                mtrx.append(R)
            else:
                # Compute eigenvalues of matrix autocorrelation
                mtrx_M = np.array([[Sxx, Sxy], [Sxy, Syy]])
                eigvalues, _ = LA.eig(mtrx_M)

                # Append minimum eigenvalue from matrix M to matrix
                mtrx.append(eigvalues.min())

    mtrx = np.array(mtrx)
    return mtrx

def draw_most_salient_points(image, np_array, radius = 1, color = (0,0,255), thickness = 1, threshold = 0):
    indices = np.unravel_index(np.argsort(-np_array, axis=None), np_array.shape)
    salient_points = []
    for i in range(threshold):
        cv.circle(image,(indices[0][i],indices[1][i]), radius, color, thickness)

    return image

# Initialization
image_list = []
kernel_size = (9,9)
std_deviation = 2

img = cv.imread(image_path)
w, h, c = img.shape

# Compute the image derivative Ix and Iy and apply the Gaussian smoothing filter
IxIx, IyIy, IxIy = image_derivative_and_smoothing(img, kernel_size, std_deviation)

window_size = 3
k_E = 0
k_R = 0.04

# Compute matrix E containing for each pixel the value of the smaller eigenvalue of M. 
matrix_E = compute_matrix(window_size, img, IxIx, IyIy, IxIy, k_E)
matrix_E = matrix_E.reshape(h-2, w-2)


# Compute matrix R which contains for every point the cornerness score
matrix_R = compute_matrix(window_size, img, IxIx, IyIy, IxIy, k_R)
matrix_R = matrix_R.reshape(h-2, w-2)


# Draw most salient points
number_of_points = 81
salient_points_E_image = draw_most_salient_points(image = img, np_array = matrix_E, color = (255,0,0), threshold = number_of_points)
salient_points_R_image = draw_most_salient_points(image = img, np_array = matrix_R, color = (255,0,0), threshold = number_of_points)


# Display figures
image_list.append(["Derivative Image IxIx", IxIx])
image_list.append(["Derivative Image IyIy", IyIy])
image_list.append(["Derivative Image IxIy", IxIy])
image_list.append(["Matrix E",matrix_E])
image_list.append(["Matrix R",matrix_R])
image_list.append(["81 most salient points from Matrix E",salient_points_E_image])
image_list.append(["81 most salient points from Matrix R",salient_points_R_image])

images = {"{}".format(image[0]): image[1] for image in image_list}
display_multiple_img(images, 4, 2, des_path=des_path)
