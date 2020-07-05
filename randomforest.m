clear;
%�������ڵ�����
global Tree;
Tree = struct('level',0,'isleaf',0,'value',[],'name','root','parent',[]); 

%�������ݼ�
[data,char]= xlsread('C:\Users\1\Desktop\��Ҷ�������ݴ��뼯\train.xlsx');
[md,nd] = size(data);
[mc,nc] = size(char);
train0 = data(:,3:nd);
label = char(2:mc,2);
featureset = char(1,3:nc);
class = unique(label); %���

%��Ҷ���ݼ����������ݣ���ÿ���������ݻ��ֵ���ͬ����
[m,n] = size(train0); 
for i = 1:n
    data = train0(:,i);
    maxval = max(data);
    minval = min(data);
    det(i) = (maxval-minval)/16;
    data = minval+round((data-minval)/det(i))*det(i);
    train(:,i) = data;
end

%�������ɭ�֣���ʮ����
 for ll = 1:10
    %�зŻص����ѡ������������
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
    %�����µ������ڵ�
    Tree = struct('level',0,'isleaf',0,'value',[],'name','root','parent',[]);   
    %������ڵ㿪ʼ������
    level = 1;parent = 'root';val = 0;
    buildtree( 1,'root',Featureset,Train,Label,0 );
    %����ÿ������Treemodel��
    for o = 1:100
        Treemodel(:,o,ll) = struct('level',0,'isleaf',0,'value',[],'name',[],'parent',[]);
    end
    [m,n] = size(Tree);
    for o = 1:n
        Treemodel(:,o,ll) = Tree(:,o);
    end
 end
 
%��ѵ�����ݽ��з���
answ = cell(md,1);
 for di = 1:md
 data = train(di,:);
 for j = 1:10
     %ѡ��һ������ȥ����Ч�Ŀսڵ�
     newtree = Treemodel(:,:,j);
      for i=1:n
          if (isempty(newtree(i).name)==1);
              break
          end
          tree(i) = newtree(i);
      end
     %�����ݽ��з���
    result(j) = treeclassfisher( data,tree,featureset,det );
 end
%ʮ����ͶƱ��ѡ��Ʊ�����ķ�����
answer = unique(result);
numanswer = zeros(1,length(answer));
for kk = 1:length(answer)
    k = strcmp(result,answer(kk));
    numanswer(kk) = sum(k);
end
[num a] = max(numanswer);
answ(di) = answer(a);
 end

 %ѵ��������׼ȷ��
Acc = sum(strcmp(label,answ))/md;
sprintf('%2.2f%%', Acc*100) 


 
 
