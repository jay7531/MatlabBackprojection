# MatlabBackprojection
Implementation of Backprojection Algorithm for CT Image Reconstruction

## 📖 Intro
이 프로젝트는 "CT 영상 재구성을 위한 Backprojection 알고리즘 구현"을 위해 진행되었습니다.



## ⚙️ 개발 환경
- Language: 'Matlab'
- Tools/IDE: 'Matlab'
- Library: 



## 🛠 주요 기능
- [기능 1] (예: CT 영상 데이터를 Backprojection으로 재구성)
- [기능 2] (예: 영상 노이즈 제거 및 필터링)
- [기능 3] (예: HW 제어 + 영상 처리 연계)



## 🖼 실행 결과
프로그램 실행 결과 예시:  

![실행 결과 예시](./images/result.png)



## 📂 프로젝트 구조
```bash
프로젝트명/
│── src/          # 소스코드
│── data/         # 샘플 데이터
│── images/       # 결과 스크린샷
│── README.md     # 설명 문서
```


## Project Question Organization
1. You may have realized from HW5 the need for zero-padding outside of your photo in order to avoid image artifacts from the filtered backprojection reconstruction. Determine the smallest size of zero-padded image for your photo. Discuss the reason for your selection for the size. In the following tasks, use the zero-padded image.
2. Create a sinogram of your photo with increasing the rotation angle (Δθ) by 1 degree (i.e., 180 angles), and show it. Here, implement by yourself the image rotation operation with the nearest neighbor interpolation method.
