function [ newnode ] = buildtree( level,parent,featureset,train,label,val )
%train��ѵ�����ݣ�label�Ǳ�ǩ���ݼ�
%parent���ڵ㣬level��ǰ������val��ǰ�ڵ��ֵ��featureset����������
%{
tree{
int level   ����
int isleaf  �Ƿ�ΪҶ�ڵ�
int value   �ڵ��ֵ
int name[]  �ڵ���
int parent[]   ���ڵ���
}
%}

 global Tree;
 newnode = struct('level',0,'isleaf',0,'value',[],'name',[],'parent',[]);
 newnode.level = level;
 newnode.parent = parent;
 newnode.value = val;
 
[m,n] = size(train) ; %n������������m����������

%���ֻ��һ�����࣬����Ҷ�ڵ㣬���ڵ�����������
if length(unique(label))==1
    newnode.isleaf = 1;
    newnode.name = label(1);
    Tree = [Tree,newnode];   
    return
end
%�����������Ϊ�գ�����Ҷ�ڵ㣬���ڵ�����������
if length(featureset)<1
    class = unique(label);
    for i = 1:length(class)                          %ͳ�Ƹ����ĳ��ִ���
%        numofclass(i) = length(find(label==class(i)))
         k = strcmp(label,class(i));
         numofclass(i)=sum(k); 
    end
    [x,y] = max(numofclass);                          %�����������
    newnode.isleaf = 1;
    newnode.name = class(y);
    Tree = [Tree,newnode];  
    return;
end

%ѡ����Ϣ������������
[maxGR,feature] = featurechoise( train,label );

%���������С������Ҷ�ڵ㣬���ڵ�����������
if maxGR<0.05
    class = unique(label);
    for i = 1:length(class)                           %ͳ�Ƹ����ĳ��ִ���
%        numofclass(i) = length(find(label==class(i)))
         k = strcmp(label,class(i));
         numofclass(i)=sum(k);
    end
    [x,y] = max(numofclass);                          %�����������
    newnode.isleaf = 1;
    newnode.name = class(y);
    Tree = [Tree,newnode];  
    return;
end

%����Ҷ�ڵ������£����з�֧                                    
newnode.isleaf = 0;                                             
newnode.name = featureset(feature);
Tree = [Tree,newnode]; 
featureset(feature)=[];
%ѡ����Ϣ���������������Ϊ��֧����
node= unique(train(:,feature));      %��֧�ڵ�
for i = 1:length(node)  
    lev = level+1;
    [newtrain newlabel ] = newdata( train,label,feature,node(i) );    %�������ݼ�
    buildtree(lev,newnode.name,featureset,newtrain,newlabel,node(i));    %������һ��֧�ڵ������
end

end

