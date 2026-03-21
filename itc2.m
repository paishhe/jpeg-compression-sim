

Img = imread('edgar-guerra-uSrh0_UslDU-unsplash.jpg');

luma_img = rgb2ycbcr(Img);
imshow(luma_img);
size(Img)



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


blockDCT = @(block_struct) dct2(block_struct.data);

dct_img_luma = blockproc(luma_img, [8 8], blockDCT);
dct_cb = blockproc(Cb, [8 8], blockDCT);
dct_cr = blockproc(Cr, [8 8], blockDCT);

imshow(log(abs(dct_img_luma)), []);
colormap parula
colorbar

% standard q= 50 quantization table
Q_table = [16 11 10 16 24 40 51 61; 12 12 14 19 26 58 60 55; ...
     14 13 16 24 40 57 69 56; 14 17 22 29 51 87 80 62; ...
     18 22 37 56 68 109 103 77; 24 35 55 64 81 104 113 92; ...
     49 64 78 87 103 121 120 101; 72 92 95 98 112 100 103 99];

% operate on with q table 


Qblock =  @(block_struct) block_struct.data / Q_table;
% Apply the quantization to the DCT coefficients
quantized_dct_luma = blockproc(dct_img_luma, [8 8], Qblock);
% quantized_dct_cb = blockproc(dct_cb, [8 8], Qblock);
% quantized_dct_cr = blockproc(dct_cr, [8 8], Qblock);
