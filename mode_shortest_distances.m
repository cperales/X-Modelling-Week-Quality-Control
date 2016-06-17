%% This classifier compares the mode of the label of the
% nearest distances

function target = mode_shortest_distances(train_set,sample,per)

if (nargin==2)
    per=20;
end

d = sum((train_set(:,1:end-1)-ones(size(train_set(:,1:end-1),1),1)*sample).^2,2);
D = [d train_set(:,end)];
target = mode(D(D(:,1)<=prctile(D(:,1),per),end));

end