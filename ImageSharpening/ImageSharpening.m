% 实验1-作业3-图像锐化（ImageSharpening）
% Student: 刘蒋沅琛（19270617）
% Date：2021/12/3

% 图像锐化实质：原图像和梯度图像相加以增强图中的变化

% 基于Sobel算子（一种3x3模板下的微分算子）
% Sobel算子引入"平均因素"，对图像中随机噪声有一定的平滑作用
% 相隔两行或两列求差分，使边缘两侧元素增强，边缘粗而亮

% Y方向的微分算子
kernel_positiveY= [
    -1,-2,-1;
    0,0,0;
    1,2,1];

% -Y方向的微分算子
kernel_negativeY = -kernel_positiveY;
% X方向的微分算子
kernel_positiveX = kernel_positiveY'; %Transfor
% Y方向的微分算子
kernel_negativeX = -kernel_positiveX;

% 45°方向的微分算子
kernel_positive45 = [
    0,1,2;
    -1,0,1;
    -2,-1,0];

% -135°方向的微分算子
kernel_negative135 = -kernel_positive45;

% -45°方向的微分算子
kernel_negative45 = [
    -2,-1,0;
    -1,0,1;
     0,1,2];

% 135°方向的微分算子
kernel_positive135 = -kernel_negative45;

image = im2double(rgb2gray(imread('../imgs/paimeng.png')));
imgBoundary = edge(image,'sobel'); %进行边缘检测
imshow(imgBoundary);
FilterPX = imfilter(image,kernel_positiveX);
FilterPY = imfilter(image,kernel_positiveY);
FilterNX = imfilter(image,kernel_negativeX);
FilterNY = imfilter(image,kernel_negativeY);
FilterP45 = imfilter(image,kernel_positive45);
FilterN45 = imfilter(image,kernel_negative45);
FilterP135 = imfilter(image,kernel_positive135);
FilterN135 = imfilter(image,kernel_negative135);
%montage({FilterPX,FilterPY,FilterNX,FilterNY,FilterP45,FilterN45,FilterP135,FilterN135})
%title('ScreenCoordinate +X +Y -X -Y +45 -45 +135 -135')
subplot(3,4,1);
imshow(FilterPX),title('Sobel +X');
subplot(3,4,2);
imshow(FilterPY),title('Sobel +Y');
subplot(3,4,3);
imshow(FilterNX),title('Sobel -X');
subplot(3,4,4);
imshow(FilterNY),title('Sobel -Y');
subplot(3,4,5);
imshow(FilterP45),title('Sobel +45°');
subplot(3,4,6);
imshow(FilterN45),title('Sobel -45°');
subplot(3,4,7);
imshow(FilterP135),title('Sobel +135°');
subplot(3,4,8);
imshow(FilterN135),title('Sobel -135°');
subplot(3,4,9);
imshow(image),title('Original');
subplot(3,4,10);
imshow(FilterP45+FilterN45),title('Sobel(+45 & -45)');
subplot(3,4,11);
imshow(image+FilterP45+FilterN45),title('Sharpening');
subplot(3,4,12);
imshow(max(FilterPX,FilterP45)+max(FilterPY,FilterN45)+max(FilterNX,FilterP135)+max(FilterNY,FilterN135)),title('Max Directions');

