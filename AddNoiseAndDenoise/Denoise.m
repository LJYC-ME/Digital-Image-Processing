% 图像去噪（Denoisy）
% Author：Frozen（https://github.com/AlterFrozen）
% Date：2021/12/3

% 使用高斯模板平滑
% 原理：图像空域与高斯正态分布函数的卷积运算，适合抑制服从正态分布的高斯噪声
image_noise = imread('./Gaussian.png');
sigma = 0.7; %高斯函数的标准差，与图像模糊度正比
%gaussianFilter = fspecial('gaussian',[2*kernelScale+1 2*kernelScale+1],sigma);
%image = imfilter(image_noise,gaussianFilter,'conv');
image_Conv3x3 = imgaussfilt(image_noise,sigma,'FilterSize',3);
image_Conv5x5 = imgaussfilt(image_noise,sigma,'FilterSize',5);
image_Conv7x7 = imgaussfilt(image_noise,sigma,'FilterSize',7);

%montage({image_noise,image})
%title('Original Image (Left) Vs. Gaussian Filtered Image (Right)')
subplot(1,4,1);
imshow(image_noise),title('Original');
subplot(1,4,2);
imshow(image_Conv3x3),title(['GaussianDenoise(σ=',num2str(sigma), ' 3x3)']);
subplot(1,4,3);
imshow(image_Conv5x5),title(['GaussianDenoise(σ=',num2str(sigma), ' 5x5)']);
subplot(1,4,4);
imshow(image_Conv7x7),title(['GaussianDenoise(σ=',num2str(sigma), ' 7x7)']);