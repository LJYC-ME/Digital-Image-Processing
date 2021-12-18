function [outputArg1] = myQuantify(pic8x8,factor,mode)
%对8x8的YCbCr图像的DCT信号进行量化
%量化效果与factor（质量因子）选取有关，一般
%mode，1时为亮度信号量化，2时为色差型号量化

%以下量化表来自《数字图像处理——使用Matlab分析与实现（清华大学出版社）P345》
mat_quantify_Y =double([%对亮度采用细量化，因为亮度比色差视觉效果更强，左上小右下大，保持低频抑制高频
    16 11 10 16 24 40 51 60;
    12 12 14 19 26 58 60 55;
    14 13 16 24 40 57 69 56;
    14 17 22 29 51 87 80 62;
    18 22 37 56 68 109 103 77;
    24 35 55 64 81 104 113 92;
    49 64 78 87 103 121 120 101;
    72 92 95 98 112 100 103 99]);

mat_quantify_CbCr =double([%对于色差采用粗量化，左上小右下大，保持低频抑制高频
    17 18 24 47 99 99 99 99;
    18 21 26 66 99 99 99 99;
    24 26 56 99 99 99 99 99;
    47 66 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99;
    99 99 99 99 99 99 99 99]);

%Function：Sq(u,v) = round(F(u,v) / Q(u,v))
%F(u,v)为DCT系数，Q(u,v)为量化表数值，Sq(u,v)为量化后结果
if factor ~= 0.0
    if mode == 1
        func = mat_quantify_Y;
    elseif mode == 2
        func = mat_quantify_CbCr;
    end
    func = func * factor;
    if size(pic8x8) ==  size(func)
        pic8x8 = round(pic8x8 ./ func);
    end
end
outputArg1 = pic8x8;
end
