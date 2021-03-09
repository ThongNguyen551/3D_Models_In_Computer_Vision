import cv2 as cv
import numpy as np
import sys
from numpy import linalg as LA
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import os

image_path = "/Users/Liam/Documents/COSI Resources/Semester 2 - UJM/Computer Vision/Lab/Lab 1/Lab 1 Materials/chessboard06.png"
des_path = "/Users/Liam/Documents/COSI Resources/Semester 2 - UJM/Computer Vision/Lab/Lab 1/Result/"

# Display multiple images
def display_multiple_img(images, image_name, rows = 1, cols=1, des_path=None):
    figure, ax = plt.subplots(nrows=rows,ncols=cols)
    for ind,title in enumerate(images):
        ax.ravel()[ind].imshow(images[title],cmap="gray")
        ax.ravel()[ind].set_title(title)
        ax.ravel()[ind].set_axis_off()
    
    figure.savefig(des_path + "Harris_Corner_Process_{}.png".format(image_name))
    plt.subplots_adjust()
    plt.tight_layout(pad=1.0)
    plt.show()

def image_derivative_and_smoothing(image, kernel_size, standard_deviation):
    # Compute image derivative
    Ix = cv.Sobel(image,cv.CV_64F,1,0,ksize=5)
    Iy = cv.Sobel(image,cv.CV_64F,0,1,ksize=5)
    # Iy = np.gradient(image, axis=0)
    # Ix = np.gradient(image, axis=1)
    IxIx = Ix * Ix
    IyIy = Iy * Iy
    IxIy = Ix * Iy

    # Apply Gaussian filter
    IxIx = cv.GaussianBlur(IxIx,kernel_size,standard_deviation)
    IyIy = cv.GaussianBlur(IyIy,kernel_size,standard_deviation)
    IxIy = cv.GaussianBlur(IxIy,kernel_size,standard_deviation)

    return IxIx, IyIy, IxIy

def compute_matrix(window_size, image, image_IxIx, image_IyIy, image_IxIy, k=0):
    offset = int(window_size/2) # Get center point
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

def nms(window_size, image):
    offset = int(window_size/2) # Get center point
    x_array = image.shape[0] - offset
    y_array = image.shape[1] - offset
    # Create empty image with zero values
    empty_image = np.zeros((image.shape[0],image.shape[1]))
    for y_pixel in range(offset, y_array):
        for x_pixel in range(offset, x_array):
            # Initialize sliding window
            start_x = x_pixel - offset
            end_x = x_pixel + offset +1
            start_y = y_pixel - offset
            end_y = y_pixel + offset +1

            # Get max value in window size            
            window_image = image[start_y : end_y, start_x : end_x]
            if int(image[y_pixel][x_pixel]) == int(np.amax(window_image)):
                empty_image[y_pixel][x_pixel] = image[y_pixel][x_pixel]

    return empty_image

def draw_most_salient_points(image, np_array, radius = 1, color = (0,0,255), thickness = 2, threshold = 0):
    # Get index list
    indices = np.unravel_index(np.argsort(-np_array, axis=None), np_array.shape)
    salient_points = []
    for i in range(threshold):
        cv.circle(image,(indices[0][i],indices[1][i]), radius, color, thickness)
    return image

def main():
    print("Course: 3D Model in Computer Vision. Lab 1: Harris Corner Detector.")
    print("Processing...")
    if __name__== "__main__" :
        # Initialization
        image_list = []
        kernel_size = (9,9)
        std_deviation = 2

        img = cv.imread(image_path)
        img_name = os.path.basename(image_path).split('.')[0]
        original_img = img.copy()
        w, h, c = img.shape

        # Convert image to gray scale image
        img_gray = cv.cvtColor(img, cv.COLOR_BGR2GRAY)

        # Compute the image derivative Ix and Iy and apply the Gaussian smoothing filter
        IxIx, IyIy, IxIy = image_derivative_and_smoothing(img_gray, kernel_size, std_deviation)

        window_size = 3
        k_E = 0
        k_R = 0.04

        # Compute matrix E containing for each pixel the value of the smaller eigenvalue of M. 
        matrix_E = compute_matrix(window_size, img_gray, IxIx, IyIy, IxIy, k_E)
        matrix_E = matrix_E.reshape(h-2, w-2)

        # Compute matrix R which contains for every point the cornerness score
        matrix_R = compute_matrix(window_size, img_gray, IxIx, IyIy, IxIy, k_R)
        matrix_R = matrix_R.reshape(h-2, w-2)

        # Non-Maximum Suspension
        matrix_E_nms = nms(window_size=11, image=matrix_E)
        matrix_R_nms = nms(window_size=11, image=matrix_R)

        # Draw most salient points
        number_of_points = 81
        salient_points_E_image = draw_most_salient_points(image = img.copy(), np_array = matrix_E, color = (255,0,0), threshold = number_of_points)
        salient_points_R_image = draw_most_salient_points(image = img.copy(), np_array = matrix_R, color = (255,0,0), threshold = number_of_points)
        salient_points_E_nms_image = draw_most_salient_points(image = img.copy(), np_array = matrix_E_nms, color = (255,0,0), threshold = number_of_points)
        salient_points_R_nms_image = draw_most_salient_points(image = img.copy(), np_array = matrix_R_nms, color = (255,0,0), threshold = number_of_points)



        # Display figures
        image_list.append(["Original Image", original_img])
        image_list.append(["Derivative Image IxIx", IxIx])
        image_list.append(["Derivative Image IyIy", IyIy])
        image_list.append(["Derivative Image IxIy", IxIy])
        image_list.append(["Matrix E",matrix_E])
        image_list.append(["Matrix R",matrix_R])
        image_list.append(["81 salient points E",salient_points_E_image])
        image_list.append(["81 salient points R",salient_points_R_image])
        image_list.append(["81 salient points NMS E",salient_points_E_nms_image])
        image_list.append(["81 salient points NMS R",salient_points_R_nms_image])

        images = {"{}".format(image[0]): image[1] for image in image_list}
        display_multiple_img(images, img_name, 5, 2, des_path=des_path)

main()

