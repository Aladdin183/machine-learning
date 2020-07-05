function [class] = treeclassfisher( data,Treemodel,featureset,det )
%������������
node = Treemodel(2);
[m,n] = size(Treemodel);
flag = 0;
while(node.isleaf~=1)
    name = node.name;
    [~,ff] = max(strcmp(featureset,name));    %�ҳ��ڸýڵ���Ҫ�����жϵ�����
    val = data(ff);
    for i=2:n
        if strcmp(Treemodel(i).parent,name)                %�ýڵ���ӽڵ�
            if (val==Treemodel(i).value)      %�����������ӽڵ�
                node = Treemodel(i);
                break
            end
        end
    end
    if (i==n && node.isleaf~=1)
       flag = 1;
       break
    end
end
if flag == 1
    class ={'unknown'};
else
    class = node.name;
end

end 


