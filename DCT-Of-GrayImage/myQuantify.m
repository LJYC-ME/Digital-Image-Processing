function [outputArg1] = myQuantify(pic8x8,mode)
%MYQUANTIFY 此处显示有关此函数的摘要
%   此处显示详细说明

mat_quantify1 =double([%压缩低频信息（人眼不敏感的冗余信息）
    1 1 1 1 1 1 1 0;
    1 1 1 1 1 1 0 0;
    1 1 1 1 1 0 0 0;
    1 1 1 1 0 0 0 0;
    1 1 1 0 0 0 0 0;
    1 1 0 0 0 0 0 0;
    1 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0]);

mat_quantify2 =double([%丢失部分高频信息（边缘轮廓）
    0 1 1 1 0 0 0 0;
    1 1 1 0 0 0 0 0;
    1 1 0 0 0 0 0 0;
    1 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0;
    1 0 0 0 0 0 0 0;
    0 0 0 0 0 0 0 0]);

if mode == 1
    func = mat_quantify1;
elseif mode == 2
    func = mat_quantify2;
end
if size(pic8x8) ==  size(func)
    pic8x8 = pic8x8 .* func;
end
outputArg1 = pic8x8;
end

