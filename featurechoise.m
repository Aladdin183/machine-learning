function [maxGR,feature] = featurechoise( train,label)
%UNTITLED2 �˴���ʾ�йش˺�����ժҪ
[m,n] = size(train); 
%�������������Ϣ����
Info = en_Entropy(label); %������
G = zeros(1,n);           %��Ϣ����
GR = zeros(1,n);          %��Ϣ�����
for i = 1:n
    classi= unique(train(:,i)); %����i������
    Infoi=zeros(1,length(classi));
    for j = 1:length(classi)
        classjofi = find(train(:,i)==classi(j));   %i����������Ϊj������
        labeljofi = label(classjofi);              %i������Ϊj�����ݶ�Ӧ�ı�ǩ
        Infoj = en_Entropy(labeljofi);             %����j�ľ�����
        ratioj = size(classjofi)/size(train(:,i)); %����j������i�ı���
        Infoi(j) = ratioj*Infoj;
    end
    InfoI = sum(Infoi);   %����i��������
    G(i) = Info-InfoI;    %����i����Ϣ����
    GR(i) = G(i)/Info;    %����i����Ϣ�����
end
[maxGR feature] = max(G);
end

