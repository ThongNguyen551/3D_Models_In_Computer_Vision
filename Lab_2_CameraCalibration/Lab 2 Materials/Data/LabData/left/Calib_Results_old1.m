% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 1906.230711701230803 ; 1926.377120343067418 ];

%-- Principal point:
cc = [ 817.597695656183305 ; 788.214442709714262 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ -0.071351951274071 ; 0.168970249183491 ; 0.020829349085846 ; -0.004508333569247 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 45.599381532259500 ; 47.447041297276066 ];

%-- Principal point uncertainty:
cc_error = [ 24.519032320816805 ; 26.531739606826761 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.024267045470793 ; 0.114496438403114 ; 0.003572145502142 ; 0.002707369603900 ; 0.000000000000000 ];

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
omc_1 = [ -2.042829e+00 ; -2.002322e+00 ; -1.834850e-01 ];
Tc_1  = [ 1.936037e+02 ; -7.833434e+02 ; 3.691921e+03 ];
omc_error_1 = [ 4.361496e-02 ; 4.377275e-02 ; 8.597365e-02 ];
Tc_error_1  = [ 4.845997e+01 ; 5.177318e+01 ; 8.969851e+01 ];

%-- Image #2:
omc_2 = [ 2.180066e+00 ; 2.189593e+00 ; 4.582756e-01 ];
Tc_2  = [ -1.839786e+02 ; -4.527759e+02 ; 2.163136e+03 ];
omc_error_2 = [ 1.672367e-02 ; 1.819199e-02 ; 3.171463e-02 ];
Tc_error_2  = [ 2.830542e+01 ; 3.013710e+01 ; 5.266724e+01 ];

%-- Image #3:
omc_3 = [ -1.836680e+00 ; -1.965080e+00 ; 2.237225e-01 ];
Tc_3  = [ 3.178939e+02 ; -4.291311e+02 ; 2.052034e+03 ];
omc_error_3 = [ 1.406551e-02 ; 1.569073e-02 ; 2.796827e-02 ];
Tc_error_3  = [ 2.759386e+01 ; 2.872653e+01 ; 4.792786e+01 ];

%-- Image #4:
omc_4 = [ -2.150586e+00 ; -2.157329e+00 ; -4.260326e-01 ];
Tc_4  = [ -1.369411e+02 ; -3.758495e+02 ; 1.870442e+03 ];
omc_error_4 = [ 1.655880e-02 ; 1.718146e-02 ; 2.820051e-02 ];
Tc_error_4  = [ 2.451292e+01 ; 2.596488e+01 ; 4.504392e+01 ];

%-- Image #5:
omc_5 = [ -2.048348e+00 ; -2.007423e+00 ; -1.492452e-01 ];
Tc_5  = [ -2.983064e+01 ; -3.267498e+02 ; 1.811038e+03 ];
omc_error_5 = [ 1.499360e-02 ; 1.639726e-02 ; 2.956172e-02 ];
Tc_error_5  = [ 2.360268e+01 ; 2.517777e+01 ; 4.298313e+01 ];

%-- Image #6:
omc_6 = [ -2.002217e+00 ; -1.971700e+00 ; -9.498578e-02 ];
Tc_6  = [ -5.527175e+00 ; -3.013576e+02 ; 1.707040e+03 ];
omc_error_6 = [ 1.216301e-02 ; 1.347319e-02 ; 2.374626e-02 ];
Tc_error_6  = [ 2.225782e+01 ; 2.372354e+01 ; 4.031889e+01 ];

%-- Image #7:
omc_7 = [ -1.777273e+00 ; -1.732713e+00 ; -3.505757e-01 ];
Tc_7  = [ -3.736336e+01 ; -3.118027e+02 ; 1.649278e+03 ];
omc_error_7 = [ 9.009506e-03 ; 1.131725e-02 ; 1.416395e-02 ];
Tc_error_7  = [ 2.156724e+01 ; 2.295522e+01 ; 3.917532e+01 ];

%-- Image #8:
omc_8 = [ -2.079958e+00 ; -2.285495e+00 ; 3.921359e-01 ];
Tc_8  = [ -1.573472e+02 ; -3.536416e+02 ; 1.641868e+03 ];
omc_error_8 = [ 1.343760e-02 ; 8.841844e-03 ; 2.211015e-02 ];
Tc_error_8  = [ 2.153158e+01 ; 2.265655e+01 ; 3.758089e+01 ];

%-- Image #9:
omc_9 = [ -1.939438e+00 ; -1.907416e+00 ; 1.217349e-02 ];
Tc_9  = [ -1.157931e+02 ; -2.710009e+02 ; 1.442295e+03 ];
omc_error_9 = [ 1.008278e-02 ; 9.433980e-03 ; 1.671009e-02 ];
Tc_error_9  = [ 1.873855e+01 ; 1.997858e+01 ; 3.334502e+01 ];

%-- Image #10:
omc_10 = [ -2.101596e+00 ; -2.059407e+00 ; -2.152004e-01 ];
Tc_10  = [ -3.504484e+02 ; -2.227424e+02 ; 1.400392e+03 ];
omc_error_10 = [ 1.173943e-02 ; 1.121359e-02 ; 2.081952e-02 ];
Tc_error_10  = [ 1.815146e+01 ; 1.957090e+01 ; 3.355413e+01 ];

%-- Image #11:
omc_11 = [ -2.164960e+00 ; -2.086971e+00 ; -3.822670e-01 ];
Tc_11  = [ -4.209592e+02 ; -1.718005e+02 ; 1.199126e+03 ];
omc_error_11 = [ 1.262962e-02 ; 1.198478e-02 ; 2.109419e-02 ];
Tc_error_11  = [ 1.578010e+01 ; 1.687033e+01 ; 2.905955e+01 ];

%-- Image #12:
omc_12 = [ -1.965408e+00 ; -1.968804e+00 ; 3.958730e-02 ];
Tc_12  = [ 1.799581e+02 ; -7.496481e+02 ; 3.556419e+03 ];
omc_error_12 = [ 2.468632e-02 ; 2.528124e-02 ; 4.882208e-02 ];
Tc_error_12  = [ 4.690371e+01 ; 4.970752e+01 ; 8.431520e+01 ];

%-- Image #13:
omc_13 = [ -2.008069e+00 ; -1.957511e+00 ; -4.633474e-01 ];
Tc_13  = [ -3.925349e+02 ; -1.601302e+02 ; 1.178992e+03 ];
omc_error_13 = [ 1.078714e-02 ; 1.255478e-02 ; 1.513996e-02 ];
Tc_error_13  = [ 1.536882e+01 ; 1.655247e+01 ; 2.893530e+01 ];

%-- Image #14:
omc_14 = [ -2.192611e+00 ; -2.184606e+00 ; 9.848989e-02 ];
Tc_14  = [ -2.459581e+02 ; -1.757766e+02 ; 1.171274e+03 ];
omc_error_14 = [ 1.090681e-02 ; 8.931767e-03 ; 2.245024e-02 ];
Tc_error_14  = [ 1.514208e+01 ; 1.620929e+01 ; 2.770583e+01 ];

%-- Image #15:
omc_15 = [ -1.902904e+00 ; -1.856677e+00 ; -3.408583e-01 ];
Tc_15  = [ -3.284474e+02 ; -1.195234e+02 ; 1.022432e+03 ];
omc_error_15 = [ 1.056824e-02 ; 1.206598e-02 ; 1.331308e-02 ];
Tc_error_15  = [ 1.316966e+01 ; 1.431267e+01 ; 2.502754e+01 ];

%-- Image #16:
omc_16 = [ -2.114897e+00 ; -2.112651e+00 ; -1.012875e-01 ];
Tc_16  = [ -3.611299e+02 ; -1.928690e+02 ; 1.001824e+03 ];
omc_error_16 = [ 1.043165e-02 ; 8.741763e-03 ; 1.813785e-02 ];
Tc_error_16  = [ 1.297130e+01 ; 1.415202e+01 ; 2.464178e+01 ];

%-- Image #17:
omc_17 = [ 2.191491e+00 ; 2.085439e+00 ; 5.539895e-02 ];
Tc_17  = [ -4.513435e+02 ; -2.116702e+02 ; 1.335425e+03 ];
omc_error_17 = [ 1.087309e-02 ; 1.374383e-02 ; 2.575531e-02 ];
Tc_error_17  = [ 1.746125e+01 ; 1.872408e+01 ; 3.239420e+01 ];

%-- Image #18:
omc_18 = [ -2.028505e+00 ; -2.160346e+00 ; 4.337137e-01 ];
Tc_18  = [ -6.254076e+01 ; -2.694146e+02 ; 1.560169e+03 ];
omc_error_18 = [ 1.245853e-02 ; 8.767387e-03 ; 2.172936e-02 ];
Tc_error_18  = [ 2.034271e+01 ; 2.144102e+01 ; 3.524658e+01 ];

%-- Image #19:
omc_19 = [ -1.798955e+00 ; -1.842566e+00 ; -1.818897e-01 ];
Tc_19  = [ 2.896104e+02 ; -7.499482e+02 ; 3.343791e+03 ];
omc_error_19 = [ 1.379222e-02 ; 1.651398e-02 ; 2.640067e-02 ];
Tc_error_19  = [ 4.433785e+01 ; 4.698789e+01 ; 7.980578e+01 ];

%-- Image #20:
omc_20 = [ -1.796932e+00 ; -1.991397e+00 ; 2.127915e-01 ];
Tc_20  = [ 3.716073e+02 ; -7.323371e+02 ; 3.059411e+03 ];
omc_error_20 = [ 1.604365e-02 ; 1.734120e-02 ; 3.130208e-02 ];
Tc_error_20  = [ 4.089610e+01 ; 4.297132e+01 ; 7.260683e+01 ];

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

