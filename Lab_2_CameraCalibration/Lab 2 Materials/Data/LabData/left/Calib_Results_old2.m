% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 1923.312675145896037 ; 1943.416498282137809 ];

%-- Principal point:
cc = [ 869.123244886553607 ; 810.058566853674165 ];

%-- Skew coefficient:
alpha_c = 0.005403629404876;

%-- Distortion coefficients:
kc = [ -0.066255803598646 ; 0.113933674565871 ; 0.023002182131817 ; 0.004405457539294 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 47.102147819580246 ; 49.276504210203385 ];

%-- Principal point uncertainty:
cc_error = [ 35.634404979487677 ; 28.871891703388844 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.002901930238603;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.024114105566499 ; 0.106561766333231 ; 0.003823992172940 ; 0.005007117767990 ; 0.000000000000000 ];

%-- Image size:
nx = 1624;
ny = 1224;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 25;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 1;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ -2.057238e+00 ; -2.027129e+00 ; -1.932267e-01 ];
Tc_1  = [ 9.563484e+01 ; -8.277155e+02 ; 3.728364e+03 ];
omc_error_1 = [ 5.269064e-02 ; 5.216609e-02 ; 1.008068e-01 ];
Tc_error_1  = [ 6.912187e+01 ; 5.651233e+01 ; 9.236953e+01 ];

%-- Image #2:
omc_2 = [ 2.163372e+00 ; 2.176437e+00 ; 4.995857e-01 ];
Tc_2  = [ -2.411576e+02 ; -4.775229e+02 ; 2.170578e+03 ];
omc_error_2 = [ 1.830198e-02 ; 1.873209e-02 ; 3.481300e-02 ];
Tc_error_2  = [ 4.017587e+01 ; 3.275864e+01 ; 5.336966e+01 ];

%-- Image #3:
omc_3 = [ -1.837028e+00 ; -1.977879e+00 ; 2.110172e-01 ];
Tc_3  = [ 2.627742e+02 ; -4.525390e+02 ; 2.072013e+03 ];
omc_error_3 = [ 1.364326e-02 ; 1.585123e-02 ; 2.779207e-02 ];
Tc_error_3  = [ 3.897822e+01 ; 3.108711e+01 ; 4.944413e+01 ];

%-- Image #4:
omc_4 = [ -2.154912e+00 ; -2.167236e+00 ; -4.722216e-01 ];
Tc_4  = [ -1.864010e+02 ; -3.972339e+02 ; 1.877474e+03 ];
omc_error_4 = [ 1.621559e-02 ; 1.733772e-02 ; 3.406572e-02 ];
Tc_error_4  = [ 3.478124e+01 ; 2.824016e+01 ; 4.574577e+01 ];

%-- Image #5:
omc_5 = [ -2.057948e+00 ; -2.026859e+00 ; -1.749351e-01 ];
Tc_5  = [ -7.791978e+01 ; -3.481527e+02 ; 1.824999e+03 ];
omc_error_5 = [ 1.666310e-02 ; 1.936536e-02 ; 3.231296e-02 ];
Tc_error_5  = [ 3.375211e+01 ; 2.745726e+01 ; 4.389013e+01 ];

%-- Image #6:
omc_6 = [ -2.009803e+00 ; -1.990838e+00 ; -1.185193e-01 ];
Tc_6  = [ -5.080964e+01 ; -3.215455e+02 ; 1.721106e+03 ];
omc_error_6 = [ 1.350210e-02 ; 1.675451e-02 ; 2.627056e-02 ];
Tc_error_6  = [ 3.180685e+01 ; 2.586573e+01 ; 4.122570e+01 ];

%-- Image #7:
omc_7 = [ -1.774812e+00 ; -1.749456e+00 ; -3.809244e-01 ];
Tc_7  = [ -8.114690e+01 ; -3.312827e+02 ; 1.661221e+03 ];
omc_error_7 = [ 9.530049e-03 ; 1.465679e-02 ; 1.987571e-02 ];
Tc_error_7  = [ 3.074921e+01 ; 2.501786e+01 ; 3.994422e+01 ];

%-- Image #8:
omc_8 = [ 2.112259e+00 ; 2.319608e+00 ; -3.577525e-01 ];
Tc_8  = [ -2.008603e+02 ; -3.726103e+02 ; 1.647743e+03 ];
omc_error_8 = [ 8.192342e-03 ; 1.429028e-02 ; 2.879509e-02 ];
Tc_error_8  = [ 3.055473e+01 ; 2.465078e+01 ; 3.799254e+01 ];

%-- Image #9:
omc_9 = [ -1.942586e+00 ; -1.923076e+00 ; -1.651527e-02 ];
Tc_9  = [ -1.539964e+02 ; -2.877692e+02 ; 1.449119e+03 ];
omc_error_9 = [ 1.102575e-02 ; 1.274564e-02 ; 2.118862e-02 ];
Tc_error_9  = [ 2.672339e+01 ; 2.172977e+01 ; 3.371959e+01 ];

%-- Image #10:
omc_10 = [ -2.104658e+00 ; -2.072435e+00 ; -2.581745e-01 ];
Tc_10  = [ -3.875366e+02 ; -2.391149e+02 ; 1.399536e+03 ];
omc_error_10 = [ 1.273195e-02 ; 1.350922e-02 ; 2.874300e-02 ];
Tc_error_10  = [ 2.586064e+01 ; 2.129264e+01 ; 3.354720e+01 ];

%-- Image #11:
omc_11 = [ -2.161838e+00 ; -2.095722e+00 ; -4.353019e-01 ];
Tc_11  = [ -4.522836e+02 ; -1.858758e+02 ; 1.193416e+03 ];
omc_error_11 = [ 1.324308e-02 ; 1.328335e-02 ; 3.212911e-02 ];
Tc_error_11  = [ 2.207576e+01 ; 1.835007e+01 ; 2.932451e+01 ];

%-- Image #12:
omc_12 = [ -1.964681e+00 ; -1.979115e+00 ; 1.897878e-02 ];
Tc_12  = [ 8.535683e+01 ; -7.905360e+02 ; 3.583108e+03 ];
omc_error_12 = [ 2.272630e-02 ; 2.332692e-02 ; 4.551907e-02 ];
Tc_error_12  = [ 6.659104e+01 ; 5.389433e+01 ; 8.613304e+01 ];

%-- Image #13:
omc_13 = [ -2.002277e+00 ; -1.968198e+00 ; -5.074786e-01 ];
Tc_13  = [ -4.235728e+02 ; -1.739843e+02 ; 1.174872e+03 ];
omc_error_13 = [ 1.155483e-02 ; 1.420269e-02 ; 2.528673e-02 ];
Tc_error_13  = [ 2.171763e+01 ; 1.802022e+01 ; 2.905778e+01 ];

%-- Image #14:
omc_14 = [ -2.202059e+00 ; -2.198067e+00 ; 6.740147e-02 ];
Tc_14  = [ -2.770157e+02 ; -1.894062e+02 ; 1.172432e+03 ];
omc_error_14 = [ 1.252002e-02 ; 1.140601e-02 ; 2.596372e-02 ];
Tc_error_14  = [ 2.161852e+01 ; 1.765558e+01 ; 2.776703e+01 ];

%-- Image #15:
omc_15 = [ -1.898576e+00 ; -1.871317e+00 ; -3.795543e-01 ];
Tc_15  = [ -3.556419e+02 ; -1.316745e+02 ; 1.020098e+03 ];
omc_error_15 = [ 1.131169e-02 ; 1.467487e-02 ; 2.215533e-02 ];
Tc_error_15  = [ 1.884197e+01 ; 1.560663e+01 ; 2.506808e+01 ];

%-- Image #16:
omc_16 = [ NaN ; NaN ; NaN ];
Tc_16  = [ NaN ; NaN ; NaN ];
omc_error_16 = [ NaN ; NaN ; NaN ];
Tc_error_16  = [ NaN ; NaN ; NaN ];

%-- Image #17:
omc_17 = [ 2.176896e+00 ; 2.070999e+00 ; 8.579077e-02 ];
Tc_17  = [ -4.864775e+02 ; -2.273616e+02 ; 1.330698e+03 ];
omc_error_17 = [ 1.336267e-02 ; 1.614695e-02 ; 2.832319e-02 ];
Tc_error_17  = [ 2.462854e+01 ; 2.039135e+01 ; 3.264186e+01 ];

%-- Image #18:
omc_18 = [ NaN ; NaN ; NaN ];
Tc_18  = [ NaN ; NaN ; NaN ];
omc_error_18 = [ NaN ; NaN ; NaN ];
Tc_error_18  = [ NaN ; NaN ; NaN ];

%-- Image #19:
omc_19 = [ NaN ; NaN ; NaN ];
Tc_19  = [ NaN ; NaN ; NaN ];
omc_error_19 = [ NaN ; NaN ; NaN ];
Tc_error_19  = [ NaN ; NaN ; NaN ];

%-- Image #20:
omc_20 = [ -1.796507e+00 ; -2.001518e+00 ; 1.912748e-01 ];
Tc_20  = [ 2.893898e+02 ; -7.669009e+02 ; 3.084053e+03 ];
omc_error_20 = [ 1.540966e-02 ; 1.696333e-02 ; 3.123332e-02 ];
Tc_error_20  = [ 5.788081e+01 ; 4.643829e+01 ; 7.451532e+01 ];

%-- Image #21:
omc_21 = [ -1.840909e+00 ; -1.913230e+00 ; -4.440321e-01 ];
Tc_21  = [ -2.931279e+00 ; -7.324415e+02 ; 3.048349e+03 ];
omc_error_21 = [ 1.322300e-02 ; 1.787197e-02 ; 2.706156e-02 ];
Tc_error_21  = [ 5.665256e+01 ; 4.624145e+01 ; 7.442204e+01 ];

%-- Image #22:
omc_22 = [ -2.099608e+00 ; -2.257352e+00 ; 3.438466e-01 ];
Tc_22  = [ -6.595540e+01 ; -6.602639e+02 ; 2.872712e+03 ];
omc_error_22 = [ 1.748899e-02 ; 1.238883e-02 ; 3.326925e-02 ];
Tc_error_22  = [ 5.335868e+01 ; 4.315664e+01 ; 6.802931e+01 ];

%-- Image #23:
omc_23 = [ -1.782301e+00 ; -1.884687e+00 ; 1.614434e-01 ];
Tc_23  = [ 2.424422e+02 ; -6.488065e+02 ; 2.853512e+03 ];
omc_error_23 = [ 1.306551e-02 ; 1.530318e-02 ; 2.524098e-02 ];
Tc_error_23  = [ 5.339425e+01 ; 4.283490e+01 ; 6.802974e+01 ];

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

