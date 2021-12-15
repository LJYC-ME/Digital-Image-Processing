% 灰度图像的频域滤波器（Frequency-domain Filter Of Gray Image）
% Author: Frozen（https://github.com/AlterFrozen）
% Date：2021/12/10

% 实验目的：对灰度图像进行离散傅里叶变换（DFT）
%                  在频域上分别使用理想的高通和低通滤波
%                  观察离散傅里叶逆变换（IDFT）后的空域图像，观察“振铃现象”
% 实验要求：采用两种不同的截止频率

% 理想滤波器
% 本质：在傅里叶平面上半径为D的圆形滤波器，D也叫做“截止频率”
% 定义：频率d(u,v)为点(u,v)到傅里叶频率域原点的距离，d(u,v)=sqrt(u²+v²)

% 理想低通滤波器
% H(u,v) = d(u,v) <= D ? 1 : 0
image = im2double(rgb2gray(imread('../imgs/paimeng.png')));
%image = mat2gray(log(1+image)); %对数变换压缩高灰度地区
%imshow(image)
image_DFT = fftshift(fft2(double(image)));%DFT+频谱迁移
[row ,col] = size(image_DFT);
graph = zeros(row,col);
%figure,imshow(image_DFT),title('傅里叶频谱图');
%求图像中心
midCol = floor(col/2);
midRow = floor(row/2);

thresh = [  10 20 40 80 ]; % 测试用的截止频率
poltRow = ceil(length(thresh)*1/2);%每行2组（4个）
cnt = 0;
for D = thresh
    for x = 1:col %以屏幕坐标系顺序遍历
        for y = 1:row
            d = sqrt((x - midCol)^2 + (y - midRow)^2);
            if d <= D
                coef = 1;
            else
                coef = 0;
            end
            graph(y,x) = coef * image_DFT(y,x);
        end % End Y
    end % End X
    cnt = cnt +1;
    subplot(poltRow,4,cnt);
    ,imshow(graph),title('滤波后频谱图 ');
    graph = real(ifft2(ifftshift(graph))); %逆变换
    cnt = cnt +1;
    subplot(poltRow,4,cnt);
    imshow(graph),title(['理想低通滤波 D = ',num2str(D)]);
end% End Iterate

figure;
% 理想高通滤波器
% H(u,v) = d(u,v) > D ? 1 : 0
image = im2double(rgb2gray(imread('../imgs/paimeng.png')));
%image = mat2gray(log(1+image)); %对数变换压缩高灰度地区
%imshow(image)
image_DFT = fftshift(fft2(double(image)));%DFT+频谱迁移
[row ,col] = size(image_DFT);
graph = zeros(row,col);
%figure,imshow(image_DFT),title('傅里叶频谱图');
%求图像中心
midCol = floor(col/2);
midRow = floor(row/2);

thresh = [  16 8 4 2 ]; % 测试用的截止频率
poltRow = ceil(length(thresh)*1/2);%每行2组（4个）
cnt = 0;
for D = thresh
    for x = 1:col %以屏幕坐标系顺序遍历
        for y = 1:row
            d = sqrt((x - midCol)^2 + (y - midRow)^2);
            if d > D
                coef = 1;
            else
                coef = 0;
            end
            graph(y,x) = coef * image_DFT(y,x);
        end % End Y
    end % End X
    cnt = cnt +1;
    subplot(poltRow,4,cnt);
    ,imshow(graph),title('滤波后频谱图 ');
    graph = real(ifft2(ifftshift(graph))); %逆变换
    cnt = cnt +1;
    subplot(poltRow,4,cnt);
    imshow(graph),title(['理想高通滤波 D = ',num2str(D)]);
end% End Iterate