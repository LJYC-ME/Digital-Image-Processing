% 图像分割（Image Segmentation）
% Author：Frozen（https://github.com/AlterFrozen）
% Date：2021/12/17

% 实验目的: 基于直方图阈值法，对灰度图像的前景和背景分割，结果显示为二值图像

% 实验原理: 阈值分割是根据图像灰度值的分布特性确定阈值T来进行分割的方法
%                 阈值T的选择直接决定分割效果，而多峰分布直方图法就是其中一种选择方法
%                 选择两峰之间的波谷作为阈值T，可以保证错误分割概率最小（只是最小）

image = rgb2gray(imread('../imgs/paimeng.png'));
subplot(2,2,1);
imshow(image),title('原图');
hist1 = imhist(image); %灰度直方图
subplot(2,2,2);
imhist(image),title('灰度直方图');
hist2 = hist1;
thresh_smooth = 1000; %控制平滑次数上限
for iterator = 1:1:thresh_smooth
    [is,peak] = Bimodal(hist1); %判断是否为双峰直方图
    if is == false  %对非双峰直方图平滑（用相邻3个像素均值平滑）
        %边缘平滑处理
        hist2(1) = (hist1(1)*2+hist1(2)) / 3.0;
        hist2(256) = (hist1(255) + hist1(256) * 2) / 3.0; 
        %内部平滑处理
        for j = 2:255 
            hist2(j)=(hist1(j-1)+hist1(j)+hist1(j+1)) / 3.0; 
        end
        hist1 = hist2;
    else %找到双峰
        break
    end
end%End Iterator
[trough , pos] = min(hist1(peak(1):peak(2))); %找到双峰间的波谷
thresh = pos + peak(1); %波谷对应的灰度
subplot(2,2,4);
stem(1:256,hist1,'Marker','none'),title('平滑后的直方图与波谷');
hold on
stem([thresh,thresh],[0,trough],'Linewidth',2);
hold off
result = zeros(size(image));
result(image>thresh) = 1; %将大于波谷的像素二值化为1
subplot(2,2,3);
imshow(result),title('双峰直方图阈值化图像分割');
