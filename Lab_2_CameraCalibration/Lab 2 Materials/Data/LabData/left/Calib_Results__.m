% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 1921.296176682691339 ; 1942.803452246749657 ];

%-- Principal point:
cc = [ 814.278702565923822 ; 798.606942058216077 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.062988488928329 ; 0.158594089438084 ; 0.022299087572089 ; -0.004916027156879 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 54.009501729453959 ; 56.357480755708856 ];

%-- Principal point uncertainty:
cc_error = [ 28.318306137526061 ; 31.724105944258099 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.028534672871801 ; 0.135072112168778 ; 0.004327892898520 ; 0.003114128880268 ; 0.000000000000000 ];

%-- Image size:
nx = 1624;
ny = 1224;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 25;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ -2.038052e+00 ; -1.995827e+00 ; -1.998684e-01 ];
Tc_1  = [ 2.001435e+02 ; -8.030928e+02 ; 3.717397e+03 ];
omc_error_1 = [ 4.753653e-02 ; 4.762828e-02 ; 9.337772e-02 ];
Tc_error_1  = [ 5.598143e+01 ; 6.185143e+01 ; 1.058912e+02 ];

%-- Image #2:
omc_2 = [ 2.182564e+00 ; 2.190612e+00 ; 4.655885e-01 ];
Tc_2  = [ -1.800319e+02 ; -4.641618e+02 ; 2.177056e+03 ];
omc_error_2 = [ 1.932242e-02 ; 2.095339e-02 ; 3.678761e-02 ];
Tc_error_2  = [ 3.267381e+01 ; 3.597193e+01 ; 6.209528e+01 ];

%-- Image #3:
omc_3 = [ -1.833761e+00 ; -1.964343e+00 ; 2.245536e-01 ];
Tc_3  = [ 3.217715e+02 ; -4.403898e+02 ; 2.067398e+03 ];
omc_error_3 = [ 1.639259e-02 ; 1.815080e-02 ; 3.257244e-02 ];
Tc_error_3  = [ 3.188098e+01 ; 3.433524e+01 ; 5.658161e+01 ];

%-- Image #4:
omc_4 = [ -2.146597e+00 ; -2.152520e+00 ; -4.305858e-01 ];
Tc_4  = [ -1.336453e+02 ; -3.859125e+02 ; 1.883565e+03 ];
omc_error_4 = [ 1.919090e-02 ; 1.998052e-02 ; 3.273796e-02 ];
Tc_error_4  = [ 2.831360e+01 ; 3.100733e+01 ; 5.313691e+01 ];

%-- Image #5:
omc_5 = [ -2.046254e+00 ; -2.006392e+00 ; -1.487532e-01 ];
Tc_5  = [ -2.660562e+01 ; -3.366194e+02 ; 1.823967e+03 ];
omc_error_5 = [ 1.763916e-02 ; 1.919506e-02 ; 3.485084e-02 ];
Tc_error_5  = [ 2.726455e+01 ; 3.008432e+01 ; 5.074820e+01 ];

%-- Image #6:
omc_6 = [ -1.999605e+00 ; -1.968716e+00 ; -1.038886e-01 ];
Tc_6  = [ -2.586864e+00 ; -3.104669e+02 ; 1.718493e+03 ];
omc_error_6 = [ 1.417588e-02 ; 1.565653e-02 ; 2.758570e-02 ];
Tc_error_6  = [ 2.570381e+01 ; 2.833713e+01 ; 4.762750e+01 ];

%-- Image #7:
omc_7 = [ -1.774518e+00 ; -1.730547e+00 ; -3.514739e-01 ];
Tc_7  = [ -3.438557e+01 ; -3.208025e+02 ; 1.661089e+03 ];
omc_error_7 = [ 1.056681e-02 ; 1.307615e-02 ; 1.642465e-02 ];
Tc_error_7  = [ 2.491784e+01 ; 2.743131e+01 ; 4.626891e+01 ];

%-- Image #8:
omc_8 = [ -2.076747e+00 ; -2.283480e+00 ; 3.929191e-01 ];
Tc_8  = [ -1.543680e+02 ; -3.621036e+02 ; 1.652389e+03 ];
omc_error_8 = [ 1.559015e-02 ; 1.022818e-02 ; 2.551810e-02 ];
Tc_error_8  = [ 2.485152e+01 ; 2.703799e+01 ; 4.432159e+01 ];

%-- Image #9:
omc_9 = [ -1.936405e+00 ; -1.905699e+00 ; 7.849705e-03 ];
Tc_9  = [ -1.132078e+02 ; -2.786941e+02 ; 1.451890e+03 ];
omc_error_9 = [ 1.177700e-02 ; 1.093707e-02 ; 1.939239e-02 ];
Tc_error_9  = [ 2.163515e+01 ; 2.385618e+01 ; 3.937725e+01 ];

%-- Image #10:
omc_10 = [ -2.098069e+00 ; -2.056131e+00 ; -2.087000e-01 ];
Tc_10  = [ -3.480218e+02 ; -2.305083e+02 ; 1.412147e+03 ];
omc_error_10 = [ 1.362832e-02 ; 1.292032e-02 ; 2.414721e-02 ];
Tc_error_10  = [ 2.097665e+01 ; 2.338747e+01 ; 3.960158e+01 ];

%-- Image #11:
omc_11 = [ -2.161905e+00 ; -2.083283e+00 ; -3.765531e-01 ];
Tc_11  = [ -4.191904e+02 ; -1.786119e+02 ; 1.210540e+03 ];
omc_error_11 = [ 1.475497e-02 ; 1.392491e-02 ; 2.459084e-02 ];
Tc_error_11  = [ 1.826759e+01 ; 2.016943e+01 ; 3.426744e+01 ];

%-- Image #12:
omc_12 = [ -1.961667e+00 ; -1.965820e+00 ; 3.645128e-02 ];
Tc_12  = [ 1.863208e+02 ; -7.689512e+02 ; 3.581699e+03 ];
omc_error_12 = [ 2.866232e-02 ; 2.929314e-02 ; 5.643871e-02 ];
Tc_error_12  = [ 5.419259e+01 ; 5.939745e+01 ; 9.955160e+01 ];

%-- Image #13:
omc_13 = [ -2.005312e+00 ; -1.954235e+00 ; -4.625940e-01 ];
Tc_13  = [ -3.906547e+02 ; -1.668082e+02 ; 1.189774e+03 ];
omc_error_13 = [ 1.267409e-02 ; 1.463524e-02 ; 1.741392e-02 ];
Tc_error_13  = [ 1.778769e+01 ; 1.978413e+01 ; 3.411532e+01 ];

%-- Image #14:
omc_14 = [ -2.186570e+00 ; -2.180142e+00 ; 9.990888e-02 ];
Tc_14  = [ -2.438276e+02 ; -1.820701e+02 ; 1.180089e+03 ];
omc_error_14 = [ 1.263648e-02 ; 1.029006e-02 ; 2.589309e-02 ];
Tc_error_14  = [ 1.749056e+01 ; 1.935737e+01 ; 3.268004e+01 ];

%-- Image #15:
omc_15 = [ -1.898145e+00 ; -1.850731e+00 ; -3.377000e-01 ];
Tc_15  = [ -3.268059e+02 ; -1.251939e+02 ; 1.031238e+03 ];
omc_error_15 = [ 1.241314e-02 ; 1.396948e-02 ; 1.527604e-02 ];
Tc_error_15  = [ 1.522187e+01 ; 1.710172e+01 ; 2.951175e+01 ];

%-- Image #16:
omc_16 = [ -2.108882e+00 ; -2.108273e+00 ; -9.678977e-02 ];
Tc_16  = [ -3.593980e+02 ; -1.985542e+02 ; 1.010539e+03 ];
omc_error_16 = [ 1.211932e-02 ; 1.005630e-02 ; 2.089511e-02 ];
Tc_error_16  = [ 1.499266e+01 ; 1.690833e+01 ; 2.904490e+01 ];

%-- Image #17:
omc_17 = [ 2.196921e+00 ; 2.092313e+00 ; 5.704544e-02 ];
Tc_17  = [ -4.491272e+02 ; -2.191593e+02 ; 1.347235e+03 ];
omc_error_17 = [ 1.259167e-02 ; 1.592765e-02 ; 3.016909e-02 ];
Tc_error_17  = [ 2.020410e+01 ; 2.237340e+01 ; 3.818987e+01 ];

%-- Image #18:
omc_18 = [ -2.025567e+00 ; -2.158259e+00 ; 4.293264e-01 ];
Tc_18  = [ -5.982307e+01 ; -2.776913e+02 ; 1.570255e+03 ];
omc_error_18 = [ 1.450750e-02 ; 1.019908e-02 ; 2.518541e-02 ];
Tc_error_18  = [ 2.348222e+01 ; 2.559194e+01 ; 4.160091e+01 ];

%-- Image #19:
omc_19 = [ -1.796370e+00 ; -1.841065e+00 ; -1.846644e-01 ];
Tc_19  = [ 2.957722e+02 ; -7.684029e+02 ; 3.368709e+03 ];
omc_error_19 = [ 1.609592e-02 ; 1.915475e-02 ; 3.074362e-02 ];
Tc_error_19  = [ 5.125402e+01 ; 5.618200e+01 ; 9.427594e+01 ];

%-- Image #20:
omc_20 = [ -1.794663e+00 ; -1.989795e+00 ; 2.086295e-01 ];
Tc_20  = [ 3.771633e+02 ; -7.492201e+02 ; 3.082234e+03 ];
omc_error_20 = [ 1.874348e-02 ; 2.017882e-02 ; 3.643687e-02 ];
Tc_error_20  = [ 4.725992e+01 ; 5.136124e+01 ; 8.572515e+01 ];

%-- Image #21:
omc_21 = [ NaN ; NaN ; NaN ];
Tc_21  = [ NaN ; NaN ; NaN ];
omc_error_21 = [ NaN ; NaN ; NaN ];
Tc_error_21  = [ NaN ; NaN ; NaN ];

%-- Image #22:
omc_22 = [ NaN ; NaN ; NaN ];
Tc_22  = [ NaN ; NaN ; NaN ];
omc_error_22 = [ NaN ; NaN ; NaN ];
Tc_error_22  = [ NaN ; NaN ; NaN ];

%-- Image #23:
omc_23 = [ NaN ; NaN ; NaN ];
Tc_23  = [ NaN ; NaN ; NaN ];
omc_error_23 = [ NaN ; NaN ; NaN ];
Tc_error_23  = [ NaN ; NaN ; NaN ];

%-- Image #24:
omc_24 = [ NaN ; NaN ; NaN ];
Tc_24  = [ NaN ; NaN ; NaN ];
omc_error_24 = [ NaN ; NaN ; NaN ];
Tc_error_24  = [ NaN ; NaN ; NaN ];

%-- Image #25:
omc_25 = [ NaN ; NaN ; NaN ];
Tc_25  = [ NaN ; NaN ; NaN ];
omc_error_25 = [ NaN ; NaN ; NaN ];
Tc_error_25  = [ NaN ; NaN ; NaN ];

