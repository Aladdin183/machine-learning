function [ newtrain newlabel ] = newdata( train,label,feature,value )
%train要分裂的数据集，feature选择的属性，value叶节点的值
 index = find(train(:,feature)==value); 
 data = train(index,:);
 newlabel = label(index,:);
 data(:,feature) = [];
 newtrain = data;
end

