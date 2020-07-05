function [ Info ] = en_Entropy( arra )
% 计算矩阵的熵
class = unique(arra); %类别
numclass = zeros(1,length(class));%各类别数量  

%如果输入类型为字符串，转换为数字类型
if isa(arra,'cell')==1
    newarra = zeros(length(arra),1);
    for i = 1:length(class)
        k = strcmp(arra,class(i));
        newarra = newarra+i*k;
        newclass(i) = i;
    end
    arra = newarra;
    class = newclass;
end

%计算经验熵
for i = 1:length(class)
    k = find(arra==class(i));
    numclass(i) = length(k);
end
p = numclass/length(arra);
Info = -p*(log(p)/log(2))';
end

