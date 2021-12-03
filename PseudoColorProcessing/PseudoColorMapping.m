function [RGB_R,RGB_G,RGB_B] = PseudoColorMapping(grayScale)
% 由灰度图像到到彩色图像的映射关系
% 使用线性插值方法将灰度值映射到彩虹色带
% Color_Red     RGB(255,0,0)
% Color_Orange  RGB(255,152,0)
% Color_Yellow  RGB(255,255,0)
% Color_Green   RGB(0,255,0)
% Color_Cyan    RGB(0,255,255)
% Color_Blue    RGB(0,0,255)
% Color_Purple  RGB(150,0,255)

level = double(grayScale) / 42.5; % To 7 levels


if (0<=level && level<1)     %Red->Orange
    RGB_R = 255;
    RGB_G = round((level-0)*152);
    RGB_B = 0;
elseif (1<=level && level<2) %Orange->Yellow
    RGB_R = 255;
    RGB_G = round(152+(level-1)*(255-152));
    RGB_B = 0;
elseif (2<=level && level<3) %Yellow->Green
    RGB_R = round(255-(level-2)*255);
    RGB_G = 255;
    RGB_B = 0;
elseif (3<=level && level<4) %Green->Cyan
    RGB_R = 0;
    RGB_G = 255;
    RGB_B = round((level-3)*255);
elseif (4<=level && level<5) %Cyan->Blue
    RGB_R = 0;
    RGB_G = round(255-(level-4)*255);
    RGB_B = 255;
elseif (5<=level && level<6) %Blue->Purple
    RGB_R = round((level-5)*150);
    RGB_G = 0;
    RGB_B = 255;
elseif (level>=6) %Purple
    RGB_R = 150;
    RGB_G = 0;
    RGB_B = 255;
end

RGB_R = RGB_R/255;
RGB_G = RGB_G/255;
RGB_B = RGB_B/255;

 