function [is,peak] = Bimodal(histgram)
%BIMODAL 此处显示有关此函数的摘要
%   此处显示详细说明
    count = 0;
    is = false;
    for j = 2:255
        if histgram(j-1)<histgram(j) && histgram(j+1) < histgram(j)
                count = count + 1;
                peak(count) = j;
                if count > 2 %不是双峰
                    return;
                end
        end
    end
    if count == 2 %是双峰
        is = true;
end

