close all;
clear;
clc;

% 필요에 따라 파일명 설정 가능
filename = 'profile.jpg';
im = imread(filename);
% 그레이스케일로 이미지 변환
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

    rotate = zeros(row, col);

    R = [cos(theta), -sin(theta); sin(theta), cos(theta)];

    for x = 1:col
        for y = 1:row
            shiftX = x - centerX;
            shiftY = y - centerY;

            cur = R * [shiftX; shiftY];

            curX = round(cur(1) + centerX);
            curY = round(cur(2) + centerY);

            if curX > 0 && curX <= col && curY > 0 && curY <= row
                rotate(y, x) = image(curY, curX);
            end
        end
    end
end
