% 灰度图像的离散余弦变换（DCT Of Gray Image）
% Author：Frozen（https://github.com/AlterFrozen）
% Date：2021/12/10

% 实验目标: ① 对灰度图像分块（8x8）对每一块进行DCT并输出频谱图（DCT 系数）
%                 ② 改变部分DCT系数（例如设计量化表、修改直流/交流系数）
%                 ③ 通过IDCT还原图像，对比并分析处理前后的图像效果

% 低频分量和高频分量：
% 低频分量（低频信号）：图像中亮度或者灰度值变化缓慢的区域，也就是图像中大片平坦的区域，描述了图像的主要部分，对整幅图像强度的综合度量
% 高频分量（高频信号）：图像变化剧烈的部分，也就是图像的边缘（轮廓）或者噪声以及细节部分，主要是对图像边缘和轮廓的度量

% DCT变换对图像进行压缩的原理：
% 减少图像中的高频分量，人眼对细节信息并不是很敏感，因此可以去除高频的信息量
% 去掉50%的高频信息存储部分，图像信息量的损失不到5%
% DCT具有很强的"能量集中"特性，大多能量集中在变换后的低频部分（左上角）

% DCT系数量化的的一般性原则
% 高频系数：大间隔量化，舍弃绝大部分取值很小或为0的高频数据
% 低频系数：小间隔量化，避免重构后发生显著的失真

image = im2double(rgb2gray(imread('../imgs/paimeng.png')));
subplot(2,4,1);
imshow(image),title('Orignal');
subplot(2,4,2);
imshow(dct2(image)),title('DCT');
%Mode1
%对图像分块进行DCT
blockSize = 8;
image_BlockDCT  = blkproc(image,[blockSize blockSize],'dct2');
subplot(2,4,3);
imshow(image_BlockDCT),title(['DCT   Block:' num2str(blockSize) 'x' num2str(blockSize)]);
% 量化DCT系数
%quantify = @(block_struct) myQuantify(block_struct.data);
mode = 1;%1过滤低频 2丢失部分高频
image_BlockDCT  = blkproc(image_BlockDCT,[blockSize blockSize],'myQuantify',mode);
% IDCT
image_BlockIDCT  = blkproc(image_BlockDCT,[blockSize blockSize],'idct2');
subplot(2,4,4);
imshow(image_BlockIDCT),title(['IDCT   Block:' num2str(blockSize) 'x' num2str(blockSize)]);
%mean(mean(image - image_BlockIDCT))%平均损失

%Mode2（便捷起见直接复制上文）
subplot(2,4,5);
imshow(image),title('Orignal');
subplot(2,4,6);
imshow(dct2(image)),title('DCT');
%对图像分块进行DCT
blockSize = 8;
image_BlockDCT  = blkproc(image,[blockSize blockSize],'dct2');
subplot(2,4,7);
imshow(image_BlockDCT),title(['DCT   Block:' num2str(blockSize) 'x' num2str(blockSize)]);
% 量化DCT系数
%quantify = @(block_struct) myQuantify(block_struct.data);
mode = 2;%1过滤低频 2丢失部分高频
image_BlockDCT  = blkproc(image_BlockDCT,[blockSize blockSize],'myQuantify',mode);
% IDCT
image_BlockIDCT  = blkproc(image_BlockDCT,[blockSize blockSize],'idct2');
subplot(2,4,8);
imshow(image_BlockIDCT),title(['IDCT   Block:' num2str(blockSize) 'x' num2str(blockSize)]);