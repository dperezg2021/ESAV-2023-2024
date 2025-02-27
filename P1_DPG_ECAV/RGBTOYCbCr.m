function YCbCr = RGBTOYCbCr(RGB)
% extraemos los canales R, G y B.

R = RGB(:,:,1);
G = RGB(:,:,2);
B = RGB(:,:,3);

Y = 0.2126 * R + 0.0722 * B + 16
Cb = 0.5389 * (B-Y) + 128
Cr = 0.6350 * (R-Y) + 128

YCbCr = cat(3, Y, Cb, Cr);
end 

