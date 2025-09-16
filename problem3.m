close all;
clear;
clc;

% 이미지 읽기 및 전처리
im = imread('profile.jpg');
im = double(rgb2gray(im));
im = im / max(im(:));

% 1번에서 zeropadding 깔아야 이미지가 잘 나온다는 얘기했고 교수님께서 수업 시간에도 언급하셨어가지고 zeropadding 깔고 이미지를 가운데에 위치하는 코드 추가했습니다!
% 대각선 길이로 크기 조정
diagonal = ceil(sqrt(size(im, 1)^2 + size(im, 2)^2));
% 대각선 길이만큼 새로운 이미지 생성하고 zero 깔기
im_padded = zeros(diagonal, diagonal);
% 센터 찾고 가운데에 이미지 배치
centerX = floor((diagonal - size(im, 2))/2) + 1;
centerY = floor((diagonal - size(im, 1))/2) + 1;
im_padded(centerY:centerY+size(im, 1)-1, centerX:centerX+size(im, 2)-1) = im;

figure, imshow(im_padded);
title("original padded image");

% 시노그램 생성
Del_Theta = 1;
Theta = 0:Del_Theta:180-Del_Theta;
projs = zeros(diagonal, length(Theta));

% proj이라는 변수로 시노그램 저장
for t = 1:length(Theta)
    projs(:, t) = sum(imrotate(im_padded, -Theta(t), 'bilinear', 'crop'), 1);

end

figure, imshow(projs, []);
title("project image");

% ram-lak filter 적용
N=size(projs,1);
RamLak = abs(linspace(-1,1,N).');

filtered_projs = zeros(size(projs));
for i = 1:size(projs, 2)
    proj = projs(:,i);
    proj_fft = fft(proj);
    filtered_proj_fft = proj_fft .* RamLak;
    filtered_projs(:, i) = real(ifft(filtered_proj_fft));
end

%reconstructedNofilter = iradon(proj, theta, 'none', pad_length);
% 이미지 재구성
recon_im = zeros(diagonal, diagonal);
for t=1:length(Theta)
    proj = filtered_projs(:, t);
    angle = deg2rad(Theta(t));
    a = linspace(-1, 1, length(proj));
    for x = 1:diagonal
        for y = 1:diagonal
            % 중심 좌표로 변환
            x0 = x - diagonal/2;
            y0 = y - diagonal/2;

            % 투영 위치 계산
            t_pos = x0 * cos(angle) + y0 * sin(angle);

            % 투영 위치에 해당하는 값을 보간하여 추출
            if t_pos >= -1 && t_pos <= 1
                % 최근접 이웃 보간
                [~, idx] = min(abs(a - t_pos));
                recon_im(x, y) = recon_im(x, y) + proj(idx);
            end
        end
    end
end

figure, imshow(recon_im, []);
title("reconstructed image");

mse = immse(im_padded, recon_im);

figure,imshow(recon_im,[]);
title(strcat('RamLak filter; MSE= ',num2str(mse)));

