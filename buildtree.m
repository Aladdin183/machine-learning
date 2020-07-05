function [ newnode ] = buildtree( level,parent,featureset,train,label,val )
%train是训练数据，label是标签数据集
%parent父节点，level当前层数，val当前节点的值，featureset特征名集合
%{
tree{
int level   层数
int isleaf  是否为叶节点
int value   节点的值
int name[]  节点名
int parent[]   父节点名
}
%}

 global Tree;
 newnode = struct('level',0,'isleaf',0,'value',[],'name',[],'parent',[]);
 newnode.level = level;
 newnode.parent = parent;
 newnode.value = val;
 
[m,n] = size(train) ; %n是特征数量，m是样本数量

%如果只有一个分类，定义叶节点，将节点加入决策树中
if length(unique(label))==1
    newnode.isleaf = 1;
    newnode.name = label(1);
    Tree = [Tree,newnode];   
    return
end
%如果特征集合为空，定义叶节点，将节点加入决策树中
if length(featureset)<1
    class = unique(label);
    for i = 1:length(class)                          %统计各类别的出现次数
%        numofclass(i) = length(find(label==class(i)))
         k = strcmp(label,class(i));
         numofclass(i)=sum(k); 
    end
    [x,y] = max(numofclass);                          %出现最多的类别
    newnode.isleaf = 1;
    newnode.name = class(y);
    Tree = [Tree,newnode];  
    return;
end

%选择信息增益最大的特征
[maxGR,feature] = featurechoise( train,label );

%如果熵增过小，定义叶节点，将节点加入决策树中
if maxGR<0.05
    class = unique(label);
    for i = 1:length(class)                           %统计各类别的出现次数
%        numofclass(i) = length(find(label==class(i)))
         k = strcmp(label,class(i));
         numofclass(i)=sum(k);
    end
    [x,y] = max(numofclass);                          %出现最多的类别
    newnode.isleaf = 1;
    newnode.name = class(y);
    Tree = [Tree,newnode];  
    return;
end

%不是叶节点的情况下，进行分支                                    
newnode.isleaf = 0;                                             
newnode.name = featureset(feature);
Tree = [Tree,newnode]; 
featureset(feature)=[];
%选择信息增益比最大的属性作为分支条件
node= unique(train(:,feature));      %分支节点
for i = 1:length(node)  
    lev = level+1;
    [newtrain newlabel ] = newdata( train,label,feature,node(i) );    %分裂数据集
    buildtree(lev,newnode.name,featureset,newtrain,newlabel,node(i));    %建立这一分支节点的子树
end

end

