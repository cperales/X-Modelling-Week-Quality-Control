%% This method compares the average distance classifier

%% Optional code
% M = csvread('data_11x11f.csv');
% M = sortrows(M,1059);
% set = make_sets3(M,4);

%% Cross validation
for j = 1:4
    fprintf('Iteration %i\n',mod(j+3,4)+1)
%% All the data
    training = [set(:,:,mod(j,4)+1);
                set(:,:,mod(j+1,4)+1); 
                set(:,:,mod(j+2,4)+1)];
    validation = set(:,:,mod(j+3,4)+1);
%% Just the 2nd experiment
%     training = [set(:,530:1059,mod(j,4)+1);
%                 set(:,530:1059,mod(j+1,4)+1);
%                 set(:,530:1059,mod(j+2,4)+1)];
%     validation = set(:,530:1059,mod(j+3,4)+1);
    %% 1st experiment
%     training = [set(:,[1:529 1059],mod(j,4)+1);
%                 set(:,[1:529 1059],mod(j+1,4)+1);
%                 set(:,[1:529 1059],mod(j+2,4)+1)];
%     validation = set(:,[1:529 1059],mod(j+3,4)+1);
%% Calculations    
    TP = 0;
    FP = 0;
    TN = 0;
    FN = 0;

    for i=1:size(validation,1)
        predicted_target = average_distance1(training,validation(i,1:end-1));
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
    fprintf('Precission (label 1) = %f\n',TP/(TP+FP))
    fprintf('Precission (label 2) = %f\n',TN/(TN+FN))
    fprintf('Recall (label 1) = %f\n',TP/(TP+FN))
    fprintf('F_Score (label 1) = %f\n',2*(TP/(TP+FN)*TP/(TP+FP))/(TP/(TP+FN) + TP/(TP+FP)))
    fprintf('\n')
end