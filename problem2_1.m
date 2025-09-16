close all;
clear;
clc;

% 필요에 따라 파일명 설정 가능
filename = 'profile.jpg';
im = imread(filename);
% 그레이스케일로 이미지 변환하고 [0,1]범위로 재조정
im_scaled = double (rgb2gray(im));
im_scaled = im_scaled/max(im_scaled(:));

[row, col] = size(im_scaled);

centerX = col / 2;
centerY = row / 2;

image = imshow(im_scaled);

angle = 0;
delta = 0.1;


while ishandle(image)
    rotate = rotateImage(im_scaled, angle, centerX, centerY);

    set(image, 'CData', rotate);
    drawnow;

    angle = angle + delta;
end

function rotate = rotateImage(image, angle, centerX, centerY)
    theta = deg2rad(angle);

    [row, col] = size(image);

    rotate = zeros(row, col, 'uint8');

    % 원본 이미지의 x, y 좌표 생성
    [X, Y] = meshgrid(1:col, 1:row);
    
    % 중심점 기준으로 이동
    shiftX = X - centerX;
    shiftY = Y - centerY;
    
    % 회전 변환 행렬 적용
    X_rotated = cos(theta) * shiftX + sin(theta) * shiftY;
    Y_rotated = -sin(theta) * shiftX + cos(theta) * shiftY;
    
    % 원래 좌표로 복원
    X_new = round(X_rotated + centerX);
    Y_new = round(Y_rotated + centerY);
    
    % 범위 벗어난 좌표 제거
    valid_idx = X_new > 0 & X_new <= col & Y_new > 0 & Y_new <= row;
    
    % 회전된 이미지 초기화
    rotated = zeros(row, col, 'uint8');
    
    % 새로운 좌표의 유효한 값만 복사
    rotated(valid_idx) = image(sub2ind([row, col], Y_new(valid_idx), X_new(valid_idx)));
end