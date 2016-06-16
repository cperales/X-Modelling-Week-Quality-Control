disp('Let s explore the data')

m = csvread('data_4f.csv');
f1 = m(:,1);
f2 = m(:,2);
f3 = m(:,3);
f4 = m(:,4);
target = m(:,5);

disp('Correlation among features')
corrcoef([f1 f2 f3 f4])
disp('Correlations including target')
corrcoef([f1 f2 f3 f4 target])

f1_new = f1(f1<prctile(f1,95) & f2<prctile(f2,95) & f3<prctile(f3,95) & f4<prctile(f4,95));
f2_new = f2(f1<prctile(f1,95) & f2<prctile(f2,95) & f3<prctile(f3,95) & f4<prctile(f4,95));
f3_new = f3(f1<prctile(f1,95) & f2<prctile(f2,95) & f3<prctile(f3,95) & f4<prctile(f4,95));
f4_new = f4(f1<prctile(f1,95) & f2<prctile(f2,95) & f3<prctile(f3,95) & f4<prctile(f4,95));
target_new = target(f1<prctile(f1,95) & f2<prctile(f2,95) & f3<prctile(f3,95) & f4<prctile(f4,95));
fprintf('Apply all the percentiles it deletes %i samples\n',length(f1) - length(f1_new))

disp('Correlation among filter features with also the target')
corrcoef([f1_new f2_new f3_new f4_new target_new])

% Matrix without outliers
M = [f1_new f2_new f3_new f4_new target_new];

%% Sort matrix, standarize, filtering, normalizing (0,1)
clc;
M = [f1_new f2_new f3_new f4_new target_new];
M = sortrows(M,5);
M = M(:,1:4);
M = zscore(M);
distance_matrix = squareform(pdist(M));
maximo = max(max(distance_matrix));
minimo = min(min(distance_matrix));
distance_matrix = (distance_matrix - minimo*ones(size(distance_matrix)))./(maximo - minimo);

imshow(distance_matrix)

%% Distance, feature 1
M = [f1_new target_new];
M = sortrows(M,2);
M = M(:,1);
M = zscore(M);
hist(M,10)
distance_matrix_1 = squareform(pdist(M));
maximo = max(max(distance_matrix_1));
minimo = min(min(distance_matrix_1));
distance_matrix_1 = (distance_matrix_1 - minimo*ones(size(distance_matrix_1)))./(maximo - minimo);
figure(1)
imshow(distance_matrix_1)

%% Distance, feature 2
M = [f2_new target_new];
M = sortrows(M,2);
M = M(:,1);
M = zscore(M);
hist(M,50)
distance_matrix_2 = squareform(pdist(M));
maximo = max(max(distance_matrix_2));
minimo = min(min(distance_matrix_2));
distance_matrix_2 = (distance_matrix_2 - minimo*ones(size(distance_matrix_2)))./(maximo - minimo);
figure(2)
imshow(distance_matrix_2)

%% Distance, feature 3
M = [f3_new target_new];
M = sortrows(M,2);
M = M(:,1);
M = zscore(M);
hist(M,50)
distance_matrix_3 = squareform(pdist(M));
maximo = max(max(distance_matrix_3));
minimo = min(min(distance_matrix_3));
distance_matrix_3 = (distance_matrix_3 - minimo*ones(size(distance_matrix_3)))./(maximo - minimo);
figure(3)
imshow(distance_matrix_3)

%% Distance, feature 4
M = [f4_new target_new];
M = sortrows(M,2);
M = M(:,1);
M = zscore(M);
distance_matrix_4 = squareform(pdist(M));
hist(M,50)
maximo = max(max(distance_matrix_4));
minimo = min(min(distance_matrix_4));
distance_matrix_4 = (distance_matrix_4 - minimo*ones(size(distance_matrix_4)))./(maximo - minimo);
figure(4)
imshow(distance_matrix_4)

%% Distance, features 1-2
M = [f1_new f2_new target_new];
M = sortrows(M,3);
M = M(:,1:2);
M = zscore(M);
distance_matrix_12 = squareform(pdist(M));
maximo = max(max(distance_matrix_12));
minimo = min(min(distance_matrix_12));
distance_matrix_12 = (distance_matrix_12 - minimo*ones(size(distance_matrix_12)))./(maximo - minimo);
figure(5)
imshow(distance_matrix_12)

%% Distance, feature 3-4
M = [f3_new f4_new target_new];
M = sortrows(M,3);
M = M(:,1:2);
M = zscore(M);
distance_matrix_34 = squareform(pdist(M));
maximo = max(max(distance_matrix_34));
minimo = min(min(distance_matrix_34));
distance_matrix_34 = (distance_matrix_34 - minimo*ones(size(distance_matrix_34)))./(maximo - minimo);
figure(6)
imshow(distance_matrix_34)