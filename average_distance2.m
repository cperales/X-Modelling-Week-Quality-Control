%% This classifier compares the average of the distances of the samples
% from target 1 with the average of the distnces of the samples from target
% 2
function target = average_distance2(train_set,sample,per)

if (nargin==2)
    per=20;
end


d = (train_set(:,1:end-1)-ones(size(train_set(:,1:end-1),1),1)*sample).^2;
d = sum(d,2);
D = [d train_set(:,end)];
D = sortrows(D,1);
D = D(D(:,1)<=prctile(D(:,1),per),:);
d1 = D(D(:,2)==1,1);
d1 = sum(d1)/(size(d1,1));
d2 = D(D(:,2)==2,1);
d2 = sum(d2)/size(d2,1);

if d1<d2
    target = 1;
else
    target = 2;
end

end