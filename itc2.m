

Img = imread('edgar-guerra-uSrh0_UslDU-unsplash.jpg');

luma_img = rgb2ycbcr(Img);
imshow(luma_img);



luminance = luma_img(:, :, 1);
Cb = luma_img(:, :, 2);
Cr = luma_img(:,:,3);

Cb_down = Cb(:, 1:4:end);
Cr_down = Cr(:, 1:4:end);

%bring the downsampled chromas to be the same size as the luma

[rows, cols, depth] = size (luma_img);

Cb_resize = imresize(Cb_down, [rows,cols], "nearest");

Cr_resize = imresize(Cb_down, [rows,cols], "nearest");

% concat the resized chroma channels 
ycbcr_img = cat(3, luminance, Cb_resize, Cr_resize);
imshow(ycbcr_img);

