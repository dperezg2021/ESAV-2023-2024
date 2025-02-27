% PRACTICA 3
%% Ejercicio1 
close all; clear all; clc;

video_original = 'video_360_raw.avi';
video_decod_1 = 'video_360_h262_raw.avi';
video_decod_2 = 'video_360_h264_raw.avi';

vid_orig = VideoReader(video_original);
vid_decod_1 = VideoReader(video_decod_1);
vid_decod_2 = VideoReader(video_decod_2);

% Obtenemos frames.
num_frames = min([vid_orig.NumFrames, vid_decod_1.NumFrames, vid_decod_2.NumFrames]);

% Arrays para almacenar la PSNR.
PSNR_values_1 = zeros(1, num_frames);
PSNR_values_2 = zeros(1, num_frames);


% Calculamos PSNR para cada frame.
for i = 1:num_frames

    frame_orig = rgb2gray(read(vid_orig, i));
    frame_decod_1 = rgb2gray(read(vid_decod_1, i));
    frame_decod_2 = rgb2gray(read(vid_decod_2, i));
    
    diff_1 = double(frame_orig) - double(frame_decod_1);
    diff_2 = double(frame_orig) - double(frame_decod_2);
    
    MSE_1 = sum(sum(diff_1.^2)) / numel(frame_orig);
    MSE_2 = sum(sum(diff_2.^2)) / numel(frame_orig);
    PSNR_values_1(i) = 10 * log10((255^2) / MSE_1);
    PSNR_values_2(i) = 10 * log10((255^2) / MSE_2);

end

% Calculamos el valor medio de la PSNR para cada códec.
PSNR_mean_1 = mean(PSNR_values_1);
PSNR_mean_2 = mean(PSNR_values_2);

% Mostramos resultados.
disp(['PSNR para H.262: ', num2str(PSNR_mean_1)]);
disp(['PSNR para H.264: ', num2str(PSNR_mean_2)]);
 