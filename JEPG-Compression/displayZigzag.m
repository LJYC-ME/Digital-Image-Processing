function outputArg = displayZigzag(pic8x8)
%使用Z字形方式扫描并显示一个8x8矩阵的DC系数和AC系数
%   此处显示详细说明

[n,m]=size(pic8x8);
if(n~=8 && m~=8)
error('Input array is NOT 8-by-8');
end
%下面这个zigzag用于对pic8x8内部元素顺序重组，数据代表顺序
zigzag=[1 2 9 17 10 3 4 11
        18 25 33 26 19 12 5 6
        13 20 27 34 41 49 42 35 
        28 21 14 7 8 15 22 29
        36 43 50 57 58 51 44 37
        30 23 16 24 31 38 45 52
        59 60 53 46 39 32 40 47
        54 61 62 55 48 56 63 64];

vec = reshape(pic8x8',1,64); %压为一维向量（先转置为行主序）
zigzagR = reshape(zigzag',1,64); %注意转置
vec = vec(zigzagR);
for i = 64:-1:1
    if (vec(i) ~= 0)
        fprintf("[DC]: %d   [AC]: ",vec(1));
        for j = 2:1:i%到最后一个非零元素
            fprintf("%d ",vec(j));
        end
        fprintf("EOB\n");
        break;
    end
end
    
outputArg = vec;
end

