function [maxGR,feature] = featurechoise( train,label)
%UNTITLED2 此处显示有关此函数的摘要
[m,n] = size(train); 
%计算个特征的信息增益
Info = en_Entropy(label); %经验熵
G = zeros(1,n);           %信息增益
GR = zeros(1,n);          %信息增益比
for i = 1:n
    classi= unique(train(:,i)); %特征i的属性
    Infoi=zeros(1,length(classi));
    for j = 1:length(classi)
        classjofi = find(train(:,i)==classi(j));   %i特征中属性为j的数据
        labeljofi = label(classjofi);              %i中属性为j的数据对应的标签
        Infoj = en_Entropy(labeljofi);             %属性j的经验熵
        ratioj = size(classjofi)/size(train(:,i)); %属性j在特征i的比率
        Infoi(j) = ratioj*Infoj;
    end
    InfoI = sum(Infoi);   %属性i的条件熵
    G(i) = Info-InfoI;    %属性i的信息增益
    GR(i) = G(i)/Info;    %属性i的信息增益比
end
[maxGR feature] = max(G);
end

