function [ newtrain newlabel ] = newdata( train,label,feature,value )
%trainҪ���ѵ����ݼ���featureѡ������ԣ�valueҶ�ڵ��ֵ
 index = find(train(:,feature)==value); 
 data = train(index,:);
 newlabel = label(index,:);
 data(:,feature) = [];
 newtrain = data;
end

