function [ Info ] = en_Entropy( arra )
% ����������
class = unique(arra); %���
numclass = zeros(1,length(class));%���������  

%�����������Ϊ�ַ�����ת��Ϊ��������
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

%���㾭����
for i = 1:length(class)
    k = find(arra==class(i));
    numclass(i) = length(k);
end
p = numclass/length(arra);
Info = -p*(log(p)/log(2))';
end

