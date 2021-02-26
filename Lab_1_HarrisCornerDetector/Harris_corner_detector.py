import cv2 as cv
import numpy as np
import sys
from numpy import linalg as LA
import matplotlib.pyplot as plt
import matplotlib.image as mpimg

image_path = "/Users/Liam/Documents/COSIResources/Semester2-UJM/Computer Vision/Lab/Sciences.CV.TP_ComputerVision_2021/Lab Session 1_Materials/chessboard00.png"
des_path = "/Users/Liam/Documents/COSIResources/Semester2-UJM/Computer Vision/Lab/lab_1/"
# display multiple images
def display_multiple_img(images, rows = 1, cols=1, des_path=None):
    figure, ax = plt.subplots(nrows=rows,ncols=cols)
    for ind,title in enumerate(images):
        ax.ravel()[ind].imshow(images[title],cmap="gray")
        ax.ravel()[ind].set_title(title)
        ax.ravel()[ind].set_axis_off()
    
    figure.savefig(des_path + "Harris_Corner_Process.png")
    # plt.tight_layout()
    # plt.show()

# Compute the image derivative Ix and Iy and apply the Gaussian smoothing filter
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

# Compute matrix E containing for each pixel the value of the smaller eigenvalue of M. 
def compute_matrix_E(window_size, image, image_IxIx, image_IyIy, image_IxIy):
    offset = int(window_size/2)
    x_array = image.shape[0] - offset
    y_array = image.shape[1] - offset
    mtrx_E = []
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
            
            # Compute eigenvalues of matrix autocorrelation M
            mtrx_M = np.array([[Sxx, Sxy], [Sxy, Syy]])
            eigvalues, _ = LA.eig(mtrx_M)

            # Append minimum eigenvalue of matrix M to matrix E
            mtrx_E.append(eigvalues.min())
    mtrx_E = np.array(mtrx_E)
    return mtrx_E

# Compute matrix R which contains for every point the cornerness score
def compute_matrix_R(window_size, image, image_IxIx, image_IyIy, image_IxIy, k=0.04):
    offset = int(window_size/2)
    x_array = image.shape[0] - offset
    y_array = image.shape[1] - offset
    mtrx_R = []
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
            
            # Calculate the determinant and trace of the matrix
            mtrx_M = np.array([[Sxx, Sxy], [Sxy, Syy]])
            det_M = LA.det(mtrx_M)
            trace_M = mtrx_M.trace()

            # Compute R
            R = det_M -  k*(trace_M**2)

            # Append R to matrix R
            mtrx_R.append(R)

    mtrx_R = np.array(mtrx_R)
    return mtrx_R

image_list = []
img = cv.imread(image_path)
w, h, c = img.shape
kernel_size = (9,9)
std_deviation = 2

IxIx, IyIy, IxIy = image_derivative_and_smoothing(img, kernel_size, std_deviation)
image_list.append(["Derivative Image IxIx", IxIx])
image_list.append(["Derivative Image IyIy", IyIy])
image_list.append(["Derivative Image IxIy", IxIy])

window_size = 3
matrix_E = compute_matrix_E(window_size, img, IxIx, IyIy, IxIy)
matrix_E = matrix_E.reshape(h-2, w-2)
image_list.append(["Matrix E",matrix_E])

k = 0.04
matrix_R = compute_matrix_R(window_size, img, IxIx, IyIy, IxIy, k)
matrix_R = matrix_R.reshape(h-2, w-2)
image_list.append(["Matrix R",matrix_R])

images = {"{}".format(image[0]): image[1] for image in image_list}
display_multiple_img(images, 3, 2, des_path=des_path)

# cv.imshow("Derivative Image IxIx", IxIx)
# cv.imshow("Derivative Image IyIy", IyIy)
# cv.imshow("Derivative Image IxIy", IxIy)
# cv.imshow("Matrix E", matrix_E)
# cv.imshow("Matrix R", matrix_R)
# cv.waitKey(0)
# sys.exit()

