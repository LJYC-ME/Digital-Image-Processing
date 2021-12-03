% 添加噪声（Add Noise）
% Author：Frozen（https://github.com/AlterFrozen）
% Date：2021/12/3

image = imread('../imgs/char1.jpg');
subplot(1,4,1);
imshow(image),title('Original')

% <imnoise函数提供的噪声模型>
% gaussian      参数(m)   均值为m方差为var的高斯噪声，默认m=0.var=0.01
% localvar      参数(v)   零均值且局部方差为V的高斯噪声，维度与图像I相同
% poisson       参数()    从数据中产生泊松噪声
% salt & pepper 参数(d)   密度为d的椒盐噪声，默认d=0.05
% speckle       参数(var) 根据公式添加乘性噪声，其中n为零均值且方差为var的均匀分布的随机噪声，默认var=0.04

%高斯噪声
image_gaussian = imnoise(image,"gaussian");
subplot(1,4,2);
imshow(image_gaussian),title('Gaussian');
imwrite(image_gaussian,'Gaussian.png')
%泊松噪声
image_poisson = imnoise(image,"poisson");
subplot(1,4,3);
imshow(image_poisson),title('Poisson');
imwrite(image_poisson,'Poisson.png')
%椒盐噪声
image_saltAndPepper = imnoise(image,"salt & pepper");
subplot(1,4,4);
imshow(image_saltAndPepper),title('Salt & Pepper');
imwrite(image_saltAndPepper,'SaltAndPepper.png')