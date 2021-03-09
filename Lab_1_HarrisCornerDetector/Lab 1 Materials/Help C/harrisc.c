#include <cv.h>
#include <highgui.h>
#include <stdio.h>
#include <string.h>
#include <math.h>
#define SOBELX 1
#define SOBELY 0

int image_height = 0, image_width = 0;

float minmax(float *img_array[], int option);
void gaussianfilter(int src[][image_width], float *dst[]);
void gaussianfilterf(float *src[], float *dst[]);
void sobelfilter(float *src[], float *dst[], int direction);
void matmul(float *src1[], float *src2[], float *dst[]);
void responsecalc(float *x2[], float *y2[], float *xy[], float *dst[], CvMat *finresponse);
void imgwrite(char image_name[]);
void imgread(char name[], int img_data[][image_width]);
void getdim(char name[]);

int main()
{
 char image[] = "building.jpg";
 imgwrite(image);

 char image_txt[] = "building.txt";
 getdim(image_txt);
 int img_data[image_height][image_width];
 imgread(image_txt, img_data);

 float *gaussian_image[image_height];
 float *sobel_image_x[image_height];
 float *sobel_image_y[image_height];
 float *sobel_image_x2[image_height];
 float *sobel_image_y2[image_height];
 float *sobel_image_xy[image_height];
 float *sobel_x2_sum[image_height];
 float *sobel_y2_sum[image_height];
 float *sobel_xy_sum[image_height];
 float *corner_response[image_height];
 for (int i = 0; i <= image_height - 1; i++)
    {
     gaussian_image[i] = (float *) malloc(image_width*sizeof(float));
     sobel_image_x[i] = (float *) malloc(image_width*sizeof(float));
     sobel_image_y[i] = (float *) malloc(image_width*sizeof(float));
     sobel_image_x2[i] = (float *) malloc(image_width*sizeof(float));
     sobel_image_y2[i] = (float *) malloc(image_width*sizeof(float));
     sobel_image_xy[i] = (float *) malloc(image_width*sizeof(float));
     sobel_x2_sum[i] = (float *) malloc(image_width*sizeof(float));
     sobel_y2_sum[i] = (float *) malloc(image_width*sizeof(float));
     sobel_xy_sum[i] = (float *) malloc(image_width*sizeof(float));
     corner_response[i] = (float *) malloc(image_width*sizeof(float));
    }

 //CvMat *sobelimgx = cvCreateMat(image_height, image_width, CV_8U);
 //CvMat *sobelimgy = cvCreateMat(image_height, image_width, CV_8U);
 CvMat *finresponse = cvCreateMat(image_height, image_width, CV_8U);

gaussianfilter(img_data, gaussian_image);

sobelfilter(gaussian_image, sobel_image_x, SOBELX);
sobelfilter(gaussian_image, sobel_image_y, SOBELY);


matmul(sobel_image_x, sobel_image_x, sobel_image_x2);
matmul(sobel_image_y, sobel_image_y, sobel_image_y2);
matmul(sobel_image_x, sobel_image_y, sobel_image_xy);


gaussianfilterf(sobel_image_x2, sobel_x2_sum);
gaussianfilterf(sobel_image_y2, sobel_y2_sum);
gaussianfilterf(sobel_image_xy, sobel_xy_sum);

responsecalc(sobel_x2_sum, sobel_y2_sum, sobel_xy_sum, corner_response, finresponse);

/*
float maxval = minmax(corner_response, image_height, image_width, 1);
float minval = minmax(corner_response, image_height, image_width, 0);
printf("%f\t%f", maxval, minval);
*/

IplImage *input_image = cvLoadImage("building.jpg", 0);
IplImage *harris_opencv = cvCreateImage(cvSize(image_width, image_height), IPL_DEPTH_32F, 1);
cvCornerHarris(input_image, harris_opencv, 7, 5, 0.04);

//cvNamedWindow("SobelX", CV_WINDOW_NORMAL);
//cvNamedWindow("SobelY", CV_WINDOW_NORMAL);
//cvNamedWindow("Sobel OpenCV", CV_WINDOW_NORMAL);
cvNamedWindow("Original", 1);
cvNamedWindow("Final Response", 1);
cvNamedWindow("Harris OpenCV", 1);
//cvShowImage("SobelX", sobelimgx);
//cvShowImage("SobelY", sobelimgy);
//cvShowImage("Sobel OpenCV", sobel_opencv);
cvShowImage("Original", input_image);
cvShowImage("Final Response", finresponse);
cvShowImage("Harris OpenCV", harris_opencv);


//cvSaveImage("buildingc.jpg", finresponse, 0);
cvWaitKey(0);
return 0;
}


float minmax(float *img_array[], int option)
{
 float val = 0;
 if (option)
 {
 for (int i = 0; i <= image_height-1; i++)
    {
     for(int j = 0; j<= image_width-1; j++)
        {
         val = val > img_array[i][j] ? val : img_array[i][j];
        }
    }
  }
  else
  {
  for (int i = 0; i <= image_height-1; i++)
    {
     for(int j = 0; j<= image_width-1; j++)
        {
         val = val < img_array[i][j] ? val : img_array[i][j];
        }
    }
  }
 return val;
}


void gaussianfilter(int src[][image_width], float *dst[])
{

 float gaussian[5][5] = {0.003765, 0.015019, 0.023792, 0.015019, 0.003765,
 0.015019, 0.059912, 0.094907, 0.059912, 0.015019,
 0.023792, 0.094907, 0.150342, 0.094907, 0.023792,
 0.015019, 0.059912, 0.094907, 0.059912, 0.015019,
 0.003765, 0.015019, 0.023792, 0.015019, 0.003765};
 /*
 float gaussian[7][7] = {0.000036, 0.000363, 0.001446, 0.002291, 0.001446, 0.000363, 0.000036,
 0.000363, 0.003676, 0.014662, 0.023226, 0.014662, 0.003676, 0.000363,
 0.001446, 0.014662, 0.058488, 0.092651, 0.058488, 0.014662, 0.001446,
 0.002291, 0.023226, 0.092651, 0.146768, 0.092651, 0.023226, 0.002291,
 0.001446, 0.014662, 0.058488, 0.092651, 0.058488, 0.014662, 0.001446,
 0.000363, 0.003676, 0.014662, 0.023226, 0.014662, 0.003676, 0.000363,
 0.000036, 0.000363, 0.001446, 0.002291, 0.001446, 0.000363, 0.000036};
 */

 int anchor;

 for (int l = 0; l < image_height; l++)
    {
     for (int m = 0; m < image_width; m++)
        {
         anchor = 5/2;
         if (l < anchor || m < anchor || l >  image_height-1-anchor || m > image_width-1-anchor)
         {
         dst[l][m] = src[l][m];
         }
         else
         {
          float sum = 0;
          for (int g = anchor; g >= -anchor; g--)
            {
             for (int h = anchor; h >= -anchor; h--)
             {
              sum = sum + (src[l-g][m-h]) * (gaussian[anchor-g][anchor-h]);
             }
            }
          dst[l][m] = sum;
         }
        }
    }
}


void gaussianfilterf(float *src[], float *dst[])
{
/*
 float gaussian[5][5] = {0.003765, 0.015019, 0.023792, 0.015019, 0.003765,
 0.015019, 0.059912, 0.094907, 0.059912, 0.015019,
 0.023792, 0.094907, 0.150342, 0.094907, 0.023792,
 0.015019, 0.059912, 0.094907, 0.059912, 0.015019,
 0.003765, 0.015019, 0.023792, 0.015019, 0.003765};
 */
 float gaussian[7][7] = {0.000036, 0.000363, 0.001446, 0.002291, 0.001446, 0.000363, 0.000036,
 0.000363, 0.003676, 0.014662, 0.023226, 0.014662, 0.003676, 0.000363,
 0.001446, 0.014662, 0.058488, 0.092651, 0.058488, 0.014662, 0.001446,
 0.002291, 0.023226, 0.092651, 0.146768, 0.092651, 0.023226, 0.002291,
 0.001446, 0.014662, 0.058488, 0.092651, 0.058488, 0.014662, 0.001446,
 0.000363, 0.003676, 0.014662, 0.023226, 0.014662, 0.003676, 0.000363,
 0.000036, 0.000363, 0.001446, 0.002291, 0.001446, 0.000363, 0.000036};

 int anchor;

 for (int l = 0; l < image_height; l++)
    {
     for (int m = 0; m < image_width; m++)
        {
         anchor = 7/2;
         if (l < anchor || m < anchor || l >  image_height-1-anchor || m > image_width-1-anchor)
         {
         dst[l][m] = src[l][m];
         }
         else
         {
          float sum = 0;
          for (int g = anchor; g >= -anchor; g--)
            {
             for (int h = anchor; h >= -anchor; h--)
             {
              sum = sum + (src[l-g][m-h]) * (gaussian[anchor-g][anchor-h]);
             }
            }
          dst[l][m] = sum;
         }
        }
    }
}

void sobelfilter(float *src[], float *dst[], int direction)
{
 int anchor;
 for (int l = 0; l < image_height; l++)
    {
     for (int m = 0; m < image_width; m++)
        {
         anchor = 5/2;
         if (l < anchor || m < anchor || l >  image_height-1-anchor || m > image_width-1-anchor)
         {
         dst[l][m] = 0;
         }
         else
         {
          float sum = 0;
          if (direction)
          {
           //int sobel[3][3] = {-1, 0, 1, -2, 0, 2, -1, 0, 1};
           int sobel[5][5] = {1, 2, 0, -2, -1, 4, 8, 0, -8, -4, 6, 12, 0, -12, -6, 4, 8, 0, -8, -4, 1, 2, 0, -2, -1};
           for (int g = anchor; g >= -anchor; g--)
             {
              for (int h = anchor; h >= -anchor; h--)
              {
               sum = sum + src[l-g][m-h] * sobel[anchor-g][anchor-h];
              }
             }
           dst[l][m] = abs(sum);
          }
          else
          {
           //int sobel[3][3] = {-1, -2, -1, 0, 0, 0, 1, 2, 1};
           int sobel[5][5] = {-1, -4, -6, -4, -1, -2, -8, -12, -8, -2, 0, 0, 0, 0, 0, 2, 8, 12, 8, 2, 1, 4, 6, 4, 1};
           for (int g = anchor; g >= -anchor; g--)
             {
              for (int h = anchor; h >= -anchor; h--)
              {
               sum = sum + src[l-g][m-h] * sobel[anchor-g][anchor-h];
              }
             }
           dst[l][m] = abs(sum);
          }
         }
        }
    }
}



void matmul(float *src1[], float *src2[], float *dst[])
{
 for (int i = 0; i <= image_height-1; i++)
    {
     for (int j = 0; j<= image_width-1; j++)
        {
         dst[i][j] = src1[i][j] * src2[i][j];
        }
    }
}


void responsecalc(float *x2[], float *y2[], float *xy[], float *dst[], CvMat *finresponse)
{
 for (int i = 0; i <= image_height-1; i++)
    {
     for (int j = 0; j <= image_width-1; j++)
        {
         float det = (x2[i][j] * y2[i][j]) - pow(xy[i][j], 2);
         float trace = x2[i][j] + y2[i][j];
         dst[i][j] = det - 0.04*trace*trace;
        }
    }

 float maxval = minmax(dst, 1);

 for (int i = 0; i <= image_height-1; i++)
    {
     for (int j = 0; j <= image_width-1; j++)
        {
         if (dst[i][j] > 10000000000000)
         {
         dst[i][j] = 255;
         //dst[i][j] = (dst[i][j]/maxval)*255;
         CV_MAT_ELEM(*finresponse, uchar, i, j) = dst[i][j];
         }
         else
         {
         dst[i][j] = 0;
         CV_MAT_ELEM(*finresponse, uchar, i, j) = dst[i][j];
         }
        }
    }
}

void imgwrite(char image_name[])
{
 IplImage *input_image;
 char image_text[20];
 strcpy(image_text, image_name);
 int m = 0;
 while(image_text[m] != '.') {m++;}
 image_text[m+1] = 't';
 image_text[m+2] = 'x';
 image_text[m+3] = 't';
 image_text[m+4] = '\0';

 input_image = cvLoadImage(image_name, 0);

 FILE *input_image_data_text;
 input_image_data_text = fopen(image_text, "w");

 uchar *input_image_data = (uchar *) input_image->imageData;

 fprintf(input_image_data_text, "%d\n", input_image->height);
 fprintf(input_image_data_text, "%d\n", input_image->width);

 int i = 0;
 while(i < input_image->width*input_image->height)
 {
  fprintf(input_image_data_text, "%d\n", input_image_data[i]);
  i++;
 }

 fclose(input_image_data_text);
}


void imgread(char image_text[], int img_data[][image_width])
{
 FILE *temp;
 temp = fopen(image_text, "r");

 fscanf(temp, "%d", &image_height);
 fscanf(temp, "%d", &image_width);

 int j = 0, k = 0;
 while(!((j+1)*k == image_width*image_height))
 {
  if(k == image_width)
   {j++;k = 0;}

  fscanf(temp, "%d", &img_data[j][k]);
  k++;
 }

 fclose(temp);

}


void getdim(char image_text[])
{
 FILE *temp;
 temp = fopen(image_text, "r");

 fscanf(temp, "%d", &image_height);
 fscanf(temp, "%d", &image_width);

 fclose(temp);
}
