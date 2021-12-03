% 伪色彩变换（Pseudo Color Processing）
% Author：Frozen（https://github.com/AlterFrozen）
% Date：2021/12/3

grayImage = rgb2gray(imread('../imgs/paimeng.png'));
grayImage = histeq(grayImage,256); %直方图均衡化
[row,col] = size(grayImage);

%Processing
outImage = zeros(row,col,3);
for i = 1:row
    for j = 1:col
        [outImage(i,j,1),outImage(i,j,2),outImage(i,j,3)] = PseudoColorMapping(grayImage(i,j));
    end % iterate col
end % iterate row
%imwrite(outImage,'picA.png')%保存图片

subplot(2,3,1);
imshow(grayImage),title('Gray Image');
subplot(2,3,2);
imhist(grayImage),title('GrayHistogram');
axis tight;
subplot(2,3,3);
imshow(outImage),title('Pseudo Color');

%------以下为图片B的重复处理过程-----

grayImage = rgb2gray(imread('../imgs/char1.jpg'));
grayImage = histeq(grayImage,256);%直方图均衡化
[row,col] = size(grayImage);

%Processing
outImage = zeros(row,col,3);
for i = 1:row
    for j = 1:col
        [outImage(i,j,1),outImage(i,j,2),outImage(i,j,3)] = PseudoColorMapping(grayImage(i,j));
    end % iterate col
end % iterate row
%imwrite(outImage,'picB.png')%保存图片

subplot(2,3,4);
imshow(grayImage),title('Gray Image');
subplot(2,3,5);
imhist(grayImage),title('GrayHistogram');
subplot(2,3,6);
imshow(outImage),title('Pseudo Color');