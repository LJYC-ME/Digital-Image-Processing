% 图像JEPG压缩（JEPG Compression）
% Author：Frozen（https://github.com/AlterFrozen）
% Date：2021/12/17

% 实验目的:  对图像进行JPEG有损压缩
%                  图像分块DCT
%                  量化ac和dc系数的Z字形编排
% 实验要求:  ① 制作三张不同的量化表，显示在不同量化表下解码后的图像
%                  ② 计算图像压缩前后的压缩比，计算原图与解压图之间的均方根误差

%算法流程：
% 图像编码->[RGB->YCbCr]->（分为8x8子块）->（零偏置转换）->（DCT变换）->【量化】->[熵编码]->压缩编码

image_RGB = imread('../imgs/paimeng.png');
%imshow(image_RGB);
image_YCbCr = rgb2ycbcr(image_RGB); %RGB->YCbCr
%imshow(image_YCbCr);
[row,col,channel] = size(image_YCbCr);

%零偏置转换
%image_YCbCr = double(image_YCbCr -128);

%图像分块（8x8）& DCT
SIZE_BLOCK = 8;
image_Y = blkproc(image_YCbCr(:,:,1),[SIZE_BLOCK SIZE_BLOCK],'dct2');
image_Cb = blkproc(image_YCbCr(:,:,2),[SIZE_BLOCK SIZE_BLOCK],'dct2');
image_Cr = blkproc(image_YCbCr(:,:,3),[SIZE_BLOCK SIZE_BLOCK],'dct2');
%figure,montage({image_YCbCr,image_Y,image_Cb,image_Cr});

%熵编码（JPEG基本系统使用Huffman编码对DCT量化系数进行熵编码进一步压缩码率）


%对不同通道进行不同量化
Factor = 5.0 ;%量化因子
image_Y = blkproc(image_Y,[SIZE_BLOCK SIZE_BLOCK],'myQuantify',Factor,1);%亮度
mage_Cb = blkproc(image_Cb,[SIZE_BLOCK SIZE_BLOCK],'myQuantify',Factor,2);%色差
mage_Cr = blkproc(image_Cr,[SIZE_BLOCK SIZE_BLOCK],'myQuantify',Factor,2);%色差
%figure,montage({image_YCbCr,image_Y,image_Cb,image_Cr});
%输出每个8x8块的Z字形编码
showZigzag = false;
if showZigzag
     blkproc(image_Y,[SIZE_BLOCK SIZE_BLOCK],'displayZigzag');
     blkproc(mage_Cb,[SIZE_BLOCK SIZE_BLOCK],'displayZigzag');
     blkproc(mage_Cr,[SIZE_BLOCK SIZE_BLOCK],'displayZigzag');
end

%不同通道反量化
image_Y = blkproc(image_Y,[SIZE_BLOCK SIZE_BLOCK],'myInverseQuantify',Factor,1);%亮度
mage_Cb = blkproc(image_Cb,[SIZE_BLOCK SIZE_BLOCK],'myInverseQuantify',Factor,2);%色差
mage_Cr = blkproc(image_Cr,[SIZE_BLOCK SIZE_BLOCK],'myInverseQuantify',Factor,2);%色差
%figure,montage({image_YCbCr,image_Y,image_Cb,image_Cr});
% IDCT
image_Y = blkproc(image_Y,[SIZE_BLOCK SIZE_BLOCK],'idct2');
image_Cb = blkproc(image_Cb,[SIZE_BLOCK SIZE_BLOCK],'idct2');
image_Cr = blkproc(image_Cr,[SIZE_BLOCK SIZE_BLOCK],'idct2');
%igure,montage({image_YCbCr,image_Y,image_Cb,image_Cr});

%恢复图像
image_YCbCr(:,:,1) = image_Y;
image_YCbCr(:,:,2) = image_Cb;
image_YCbCr(:,:,3) = image_Cr;
image_RGB_New  = ycbcr2rgb(image_YCbCr);
imwrite(image_RGB,'./original.jpg')
imwrite(image_RGB_New,'./compressed.jpg')
%计算压缩比和均方误差
original = dir('./original.jpg');
compressed = dir('compressed.jpg');
compressRatio = original.bytes / compressed.bytes;
MSE = mean( mean( (double(image_RGB_New-image_RGB).^2).^0.5 ) );
figure,montage({image_RGB,image_RGB_New}),title(['质量因子：',num2str(Factor),'      压缩比：',num2str(compressRatio),'      均方误差(R,G,B)：',num2str(MSE)]);%与初始图片对比
