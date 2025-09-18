close all;
clear;
clc;

% 필요에 따라 파일명 설정 가능
filename = 'profile.jpg';
im = imread(filename);
% 그레이스케일로 이미지 변환하고 [0,1]범위로 재조정
im_scaled = double (rgb2gray(im));
im_scaled = im_scaled/max(im_scaled(:));

% 오리지널 이미지 띄우기
figure, imshow(im_scaled, [0,1]);
title("Original Image");

% 이미지의 행과 열 저장
[row, col] = size(im_scaled);
% 이미지 대각선 길이 저장
pad_length = ceil(sqrt(row^2 + col^2));
% 대각선 길이만큼의 zero padding을 생성
new_size = [pad_length, pad_length];
padded_im = zeros(new_size);

% 중앙에 이미지 배치
start_row = floor((pad_length - row) / 2) + 1;
start_col = floor((pad_length - col) / 2) + 1;

padded_im(start_row:start_row+row - 1, start_col:start_col+col - 1) = im_scaled

% zero padded 이미지 띄우기
figure, imshow(padded_im);
title("Zero Padded Image");

% sinogram 생성
angles = 180;       % 회전하는 각도는 180degree
theta = 0:angles-1;
proj = zeros(pad_length, length(theta));

for t = 1:length(theta)
    proj(:,t) = sum(imrotate(padded_im, theta(t), 'bilinear', 'crop'), 1);
end

% 이미지 띄우기
figure, imshow(proj, []);
title('projection image');

reconstructedNofilter = iradon(proj, theta, 'none', pad_length);
mseNone = immse(padded_im, reconstructedNofilter);
reconstructedRamLak = iradon(proj, theta, 'Ram-Lak', pad_length);
mseRamLak = immse(padded_im, reconstructedRamLak);
reconstructedHannWindowed = iradon(proj, theta, 'Hann', pad_length);
mseHann = immse(padded_im, reconstructedHannWindowed);

figure, imshow(imrotate(reconstructedNofilter, 180), []);
title(strcat('no filter; MSE = ', num2str(mseNone)));
figure, imshow(imrotate(reconstructedRamLak, 180), []);
title(strcat('Ram-Lak; MSE = ', num2str(mseRamLak)));
figure, imshow(imrotate(reconstructedHannWindowed, 180), []);
title(strcat('Hann-Windowed Ram-Lak; MSE = ', num2str(mseHann)));
