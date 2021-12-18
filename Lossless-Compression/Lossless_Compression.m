% 灰度图像的无损编码/压缩算法（Lossless Compression）
% Author：Frozen（https://github.com/AlterFrozen）
% Date：2021/12/17

% 实验目标: ① 设计预测算法实现灰度图像的一维无损预测压缩
%                 ② 将预测压缩后的一维向量（由预测误差组成）进行一维游程编码
%                 ③ 输出压缩前后的存储空间，计算压缩率

% 实验原理：
% 像素间有相关性，可以仅对每个像素中提取相对于上一个像素的新信息来减少冗余
% 无损预测编码系统主要由1个编码器和1个解码器组成
% 当输入图像的像素序列 fn (n = 1, 2, … )逐个进入编码器时
% 预测器会根据若干个过去的输入数据计算产生对当前输入像素的预测值
% 预测误差: error(n) = pixel(n) - pixel_predict(n)
% 解压图像的像素序列: pixel(n) = error(n) + pixel_predict(n)

% 算法流程：
% [读入图像]->(转换为灰度图像)->(按行压缩为一维向量)
% ->(1D线性预测)->(一维游程编码)->[计算压缩效果]

%path_image = '../imgs/paimeng.png';
path_image = '../imgs/block.png';%纯色块压缩率超高
image_Gray = rgb2gray(imread(path_image));
%figure,imshow(image_Gray);
[row,col] = size(image_Gray);
capacity = row*col;
image_Gray = reshape(image_Gray',1,capacity); 
%disp(image_Gray);

% 1D线性预测（pixel_predict(x,y) = round(coef * f(x-1,y))，由于一维所以不用考虑y）
coef = 1.0; %通常取 1.0
error = zeros(1,capacity); %第一个像素无法预测
pixel_predict = zeros(1,capacity); %第一个像素无法预测
for i = 2:1:capacity %从第二个像素开始
    pixel_predict(i) = round(coef*image_Gray(i-1));
    error(i) = image_Gray(i) - pixel_predict(i);
end


% 游程编码 (Run-Length-Encoding, RLE )
error_RLE = cell(1,capacity);%采用字符串拼接方法做
pivot = 1;%指向cell
cnt = 1;
reference = error(1);%编码对象（参照物）
for i = 2:1:capacity
    if error(i) == reference
        cnt = cnt +1;
        if i == capacity
            error_RLE{pivot} = [cnt,reference];
            pivot = pivot + 1;
        end
    else
        error_RLE{pivot} = [cnt,reference];
        pivot = pivot + 1;
        cnt = 1;
        reference = error(i);
    end
end
% 保存解压需要的数据
% pixel(n) = pixel_predict(n) + errer(n)
fprintf("Saving......\n");
file = fopen('./data_compressed.txt','w');
fprintf(file,"Size: %d Coef: %f",capacity,coef);%使读取时候可以预分配
fprintf(file,"\n#error_RLE\n");
for i = 1:1:pivot-1
    fprintf(file,"%d %d ",error_RLE{i});
end
fprintf("Successfully!\n");
fclose(file);%没有对返回值判断
%计算压缩比
original = dir(path_image);
compressed = dir('./data_compressed.txt');
compressRatio = original.bytes / compressed.bytes;
fprintf("Compress Ratio: %.2f\n",compressRatio);