

clc; clearvars; close all;
 
img1 = imread('image21.tif');
 
subplot(2, 3, 1);
imshow(img1);
title("Original Image");
 
 
img2 = medfilt2(img1);
subplot(2, 3, 2);
imshow(img2);
title("Median Filtered Image");
 
PQ = paddedsize(size(img1));
 
H1 = notch('btw', PQ(1), PQ(2), 7,17,11);
H2 = notch('btw', PQ(1), PQ(2), 7, 43,22);
H3 = notch('btw', PQ(1), PQ(2), 7, 471,491);
H4 = notch('btw', PQ(1), PQ(2), 7, 501,499);
 
subplot(2, 3, 5);
H_combined = H1 .* H2 .* H3 .* H4;
imshow(fftshift(H_combined));
title("Shifted");
 
F = fft2(double(img1), PQ(1), PQ(2));
image20 = F .* H_combined;
img20 = real(ifft2(image20));
img20 = img20(1:size(img1, 1), 1:size(img1, 2));
subplot(2, 3, 3);
imshow(img20, []);
title("Notch Filtered Image");
 
img3 = img1;
Ff = fft2(img3);
Fsh = fftshift(Ff);
S = log(1 + abs(Fsh));
subplot(2, 3, 4);
imshow(S, []);
title("Fourier Spectrum Transform");
 
 
Fcf = fftshift(image20);
Ss = log(1 + abs(Fcf));
subplot(2, 3, 6);
imshow(Ss, []);
title("Fourier Spectrum Transform of Notch Filtered");

