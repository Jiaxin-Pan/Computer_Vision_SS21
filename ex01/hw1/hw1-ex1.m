clear
%(b) Load the image into the workspace.
I = imread('lena.png');
%(c) Determine the size of the image and show the image.
whos I
  Name        Size                Bytes  Class    Attributes

  I         512x512x3            786432  uint8              

imshow(I)
%(d) Convert the image to gray scale
I_gray = rgb2gray(I);
imshow(I_gray)
%and determine the maximum and the minimum value of the image.
min_intensity=min(I_gray(:));
max_intensity=max(I_gray(:)); 
min_intensity=min(I_gray(:))

min_intensity =

  <a href="matlab:helpPopup uint8" style="font-weight:bold">uint8</a>

   25

max_intensity=max(I_gray(:))

max_intensity =

  <a href="matlab:helpPopup uint8" style="font-weight:bold">uint8</a>

   245

%(e) Apply a gaussian smoothing filter and save the output image.
Iblur1 = imgaussfilt(I_gray,2);
Iblur2 = imgaussfilt(I_gray,4);
Iblur3 = imgaussfilt(I_gray,8);
imwrite(I_gray,'gray_scale.png')
imwrite(Iblur1,'Smoothed image_\sigma = 2.png')
imwrite(Iblur2,'Smoothed image_\sigma = 4.png')
imwrite(Iblur3,'Smoothed image_\sigma = 8.png')
%(f) Show 1) the original image, 2) the gray scale image and 3) the filtered image in one figure
and give the figures appropriate titles.
{Error using <a href="matlab:matlab.internal.language.introspective.errorDocCallback('and')" style="font-weight:bold"> & </a>
Too many input arguments.
} 
%(f) Show 1) the original image, 2) the gray scale image and 3) the filtered image in one figure
%and give the figures appropriate titles.
matlab.internal.language.introspective.errorDocCallback('and')
ax1 = subplot(2,3,1);
imshow(I)
title('the original image')
ax1 = subplot(2,3,2);
imshow(I_gray)
title('the gray scale image') 
ax1 = subplot(2,3,4);
imshow(Iblur1)
title('Smoothed image, \sigma = 2') 
ax1 = subplot(2,3,5);
imshow(Iblur2)
title('Smoothed image, \sigma = 4')
ax1 = subplot(2,3,6);
imshow(Iblur3)
title('Smoothed image, \sigma = 8')
diary off
