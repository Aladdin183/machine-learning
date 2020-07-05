clear;
%定义树节点类型
global Tree;
Tree = struct('level',0,'isleaf',0,'value',[],'name','root','parent',[]); 

%加载数据集
[data,char]= xlsread('C:\Users\1\Desktop\树叶分类数据代码集\train.xlsx');
[md,nd] = size(data);
[mc,nc] = size(char);
train0 = data(:,3:nd);
label = char(2:mc,2);
featureset = char(1,3:nc);
class = unique(label); %类别

%树叶数据集是连续数据，将每个特征数据划分到不同区间
[m,n] = size(train0); 
for i = 1:n
    data = train0(:,i);
    maxval = max(data);
    minval = min(data);
    det(i) = (maxval-minval)/16;
    data = minval+round((data-minval)/det(i))*det(i);
    train(:,i) = data;
end

%生成随机森林，共十棵树
 for ll = 1:10
    %有放回地随机选择特征与样本
     k = randperm(64); 
%      m = randperm(10);
     kk = sort(k(1:32));
%      mm = m(1:10);
%      Train1 = [];
       Label = label;
%      Label = [];
%      for i = 1:length(class)
%          A = train(mm+(i-1)*10,:);
%          L = label(mm+(i-1)*10);
%          Train1 = [Train1;A];
%          Label = [Label;L];
%      end
     Train = [];
     Featureset = [];
     for j = 1:3
         B = train(:,kk+(j-1)*64);
         Train = [Train B];
         C = featureset(:,kk+(j-1)*64);
         Featureset = [Featureset C];
     end
    %建立新的树跟节点
    Tree = struct('level',0,'isleaf',0,'value',[],'name','root','parent',[]);   
    %定义根节点开始建立树
    level = 1;parent = 'root';val = 0;
    buildtree( 1,'root',Featureset,Train,Label,0 );
    %保存每棵树到Treemodel中
    for o = 1:100
        Treemodel(:,o,ll) = struct('level',0,'isleaf',0,'value',[],'name',[],'parent',[]);
    end
    [m,n] = size(Tree);
    for o = 1:n
        Treemodel(:,o,ll) = Tree(:,o);
    end
 end
 
%对训练数据进行分类
answ = cell(md,1);
 for di = 1:md
 data = train(di,:);
 for j = 1:10
     %选择一棵树，去掉无效的空节点
     newtree = Treemodel(:,:,j);
      for i=1:n
          if (isempty(newtree(i).name)==1);
              break
          end
          tree(i) = newtree(i);
      end
     %对数据进行分类
    result(j) = treeclassfisher( data,tree,featureset,det );
 end
%十棵树投票，选择票数最多的分类结果
answer = unique(result);
numanswer = zeros(1,length(answer));
for kk = 1:length(answer)
    k = strcmp(result,answer(kk));
    numanswer(kk) = sum(k);
end
[num a] = max(numanswer);
answ(di) = answer(a);
 end

 %训练集分类准确率
Acc = sum(strcmp(label,answ))/md;
sprintf('%2.2f%%', Acc*100) 


 
 
