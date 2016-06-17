%% This method compares the average distance classifier

%Optional code
M = csvread('data_4f.csv');
M = sortrows(M,5);
set = make_sets_4f(M,4);


for j = 1:4
    fprintf('Iteration %i\n',j)
    training = [set(:,:,mod(j,4)+1); set(:,:,mod(j+1,4)+1); set(:,:,mod(j+2,4)+1)];
    validation = set(:,:,mod(j+3,4)+1);
    TP = 0;
    FP = 0;
    TN = 0;
    FN = 0;
    
    % Filtering outliers just in the traning set
    f1 = training(:,1);
    f2 = training(:,2);
    f3 = training(:,3);
    f4 = training(:,4);
    target = training(:,5);
    f1_new = f1(f1<prctile(f1,95) & f2<prctile(f2,95) & f3<prctile(f3,95) & f4<prctile(f4,95));
    f2_new = f2(f1<prctile(f1,95) & f2<prctile(f2,95) & f3<prctile(f3,95) & f4<prctile(f4,95));
    f3_new = f3(f1<prctile(f1,95) & f2<prctile(f2,95) & f3<prctile(f3,95) & f4<prctile(f4,95));
    f4_new = f4(f1<prctile(f1,95) & f2<prctile(f2,95) & f3<prctile(f3,95) & f4<prctile(f4,95));
    target_new = target(f1<prctile(f1,95) & f2<prctile(f2,95) & f3<prctile(f3,95) & f4<prctile(f4,95));
    training = [f1_new f2_new f3_new f4_new target_new];
%     training = [f3_new f4_new target_new];


    for i=1:size(validation,1)
        predicted_target = average_distance(training,validation(i,1:end-1));
        real_target = validation(i,end);
        if real_target == 1 && predicted_target == 1
            TP = TP + 1;
        elseif real_target == 1 && predicted_target == 2
            FN = FN + 1;
        elseif real_target == 2 && predicted_target == 2
            TN = TN + 1;
        else
            FP = FP + 1;
        end
    end
    total = TP + FP + TN + FN;
    fprintf('Total = %i\n',total)
    fprintf('TP = %i, percentage = %f\n',TP,TP/total)
    fprintf('TN = %i, percentage = %f\n',TN,TN/total)
    fprintf('FN = %i, percentage = %f\n',FN,FN/total)
    fprintf('FP = %i, percentage = %f\n',FP,FP/total)
    fprintf('Success = %f\n',(TP+TN)/(TP+FP+TN+FN))
    fprintf('Precission = %f\n',TP/(TP+FP))
    fprintf('Recall = %f\n',TP/(TP+FN))
    fprintf('\n')
end