function [class] = treeclassfisher( data,Treemodel,featureset,det )
%决策树分类器
node = Treemodel(2);
[m,n] = size(Treemodel);
flag = 0;
while(node.isleaf~=1)
    name = node.name;
    [~,ff] = max(strcmp(featureset,name));    %找出在该节点需要进行判断的数据
    val = data(ff);
    for i=2:n
        if strcmp(Treemodel(i).parent,name)                %该节点的子节点
            if (val==Treemodel(i).value)      %符合条件的子节点
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


