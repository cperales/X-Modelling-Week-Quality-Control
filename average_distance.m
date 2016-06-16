%% This classifier compares the average of the distances of the samples
% from target 1 with the average of the distnces of the samples from target
% 2
function target = average_distance(train_set,sample)
cont1 = 0;
cont2 = 0;
d1 = 0;
d2 = 0;
for i=1:size(train_set,1)
    if train_set(i,end) == 1
        d1 = d1 + norm(train_set(i,1:end-1)-sample,2);
        cont1 = cont1 + 1;
    else
        d2 = d2 + norm(train_set(i,1:end-1)-sample,2);
        cont2 = cont2 + 1;
    end
end
% Normalize de distance to get the average
d1 = d1/cont1;
d2 = d2/cont2;
if d1<d2
    target = 1;
else
    target = 2;
end