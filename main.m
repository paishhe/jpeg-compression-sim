

Img = imread('edgar-guerra-uSrh0_UslDU-unsplash.jpg');

luma_img = rgb2ycbcr(Img);
imshow(luma_img);



luminance = luma_img(:, :, 1);
Cb = luma_img(:, :, 2);
Cr = luma_img(:,:,3);

% perform 4:1:1 subsampling
Cb_down = Cb(:, 1:4:end);
Cr_down = Cr(:, 1:4:end);

%bring the downsampled chromas to be the same size as the luma

[rows, cols, depth] = size (luma_img);

Cb_resize = imresize(Cb_down, [rows,cols], "nearest");

Cr_resize = imresize(Cb_down, [rows,cols], "nearest");

% concat the resized chroma channels 
ycbcr_img = cat(3, luminance, Cb_resize, Cr_resize);
imshow(ycbcr_img);

% taking DCT of the subsampled image, the luma and chromas separately

dct_img_luma = dct2(ycbcr_img(:, :, 1));
dct_chroma_blue = dct2(dct_img(:,:,2));
dct_chroma_red = dct2(ycbcr_img(:,:,3));

imshow(log(abs(dct_img_luma)), []);
colormap parula
colorbar

Q_table = [16 11 10 16 24 40 51 61; 12 12 14 19 26 58 60 55; ...
     14 13 16 24 40 57 69 56; 14 17 22 29 51 87 80 62; ...
     18 22 37 56 68 109 103 77; 24 35 55 64 81 104 113 92; ...
     49 64 78 87 103 121 120 101; 72 92 95 98 112 100 103 99];

% use the q-table matrix to mutiply with the dct_img_luma 
%then check later

