%% This method compares the average distance classifier

%% Optional code
M = csvread('data_11x11f.csv');
M = sortrows(M,1059);
set = make_sets3(M,4);

%% Cross validation
per_accuracy = [];
per_vector = 5:5:70;
for per = per_vector
    % Initialites vectors
    fscore1 = [];
    recall_vector = [];
    fscore2 = [];
    specifity_vector = [];
    precission_vector2 = [];
    precission_vector1 = [];
    accuracy_vector = [];
    fprintf('Percentile %i: ',per)
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
            predicted_target = average_distance1(training,validation(i,1:end-1),per);
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
        fprintf('Accuracy = %f\n',(TP+TN)/(TP+FP+TN+FN))
        fprintf('Precission (label 1) = %f\n',TP/(TP+FP))
        fprintf('Recall (label 1) = %f\n',TP/(TP+FN))
        % Recall = sensitive
        fprintf('F_Score (label 1) = %f\n',2*(TP/(TP+FN)*TP/(TP+FP))/(TP/(TP+FN) + TP/(TP+FP)))
        fprintf('\n')
        recall_vector = [recall_vector TP/(TP+FN)];
        specifity_vector = [specifity_vector TN/(TN+FP)];
        precission_vector2 = [precission_vector2 TN/(TN+FN)];
        precission_vector1 = [precission_vector1 TP/(TP+FP)];
        accuracy_vector = [accuracy_vector (TP+TN)/(TP+FP+TN+FN)];
        fscore1 = [fscore1 2*(TP/(TP+FN)*TP/(TP+FP))/(TP/(TP+FN) + TP/(TP+FP))];
        fscore2 = [fscore2 2*specifity_vector(j)*precission_vector2(j)/(precission_vector2(j) + specifity_vector(j))];
    end
    
    per_accuracy = [per_accuracy mean(accuracy_vector)];
    fprintf('\nAverage values\n')
    fprintf('Accuracy = %f\n',mean(accuracy_vector))
    fprintf('Precission (label 1) = %f\n',mean(precission_vector1))
    fprintf('Precission (label 2) = %f\n',mean(precission_vector2))
    fprintf('Recall (label 1) = %f\n',mean(recall_vector))
    fprintf('Specifity (label 2) = %f\n',mean(specifity_vector))
    fprintf('F_Score (label 1) = %f\n',mean(fscore1))
    fprintf('F_Score (label 2) = %f\n',mean(fscore2))
    fprintf('\n')
end
per_matrix = [per_vector; per_accuracy]
%% Results with percentile 5th
% Accuracy = 0.811823
% Precission (label 1) = 0.848641
% Precission (label 2) = 0.725876
% Recall (label 1) = 0.878475
% Recall (label 2) = 0.672535
% F_Score (label 1) = 0.863296
% F_Score (label 2) = 0.698169
%% Results with percentile 10th
% Accuracy = 0.821083
% Precission (label 1) = 0.861022
% Precission (label 2) = 0.732758
% Recall (label 1) = 0.877001
% Recall (label 2) = 0.704225
% F_Score (label 1) = 0.868934
% F_Score (label 2) = 0.718191
%% Results with percentile 15th
% Accuracy = 0.842165
% Precission (label 1) = 0.889934
% Precission (label 2) = 0.747376
% Recall (label 1) = 0.874895
% Recall (label 2) = 0.773768
% F_Score (label 1) = 0.882341
% F_Score (label 2) = 0.760311
%% Results with percentile 20th
% Success = 0.845869
% Precission (label 1) = 0.908246
% Precission (label 2) = 0.735163
% Recall (label 1) = 0.858888
% Recall (label 2) = 0.818662
% F_Score (label 1) = 0.882877
% F_Score (label 2) = 0.774669
%% Results with percentile 25th
% Accuracy = 0.844587
% Precission (label 1) = 0.927128
% Precission (label 2) = 0.715596
% Recall (label 1) = 0.835931
% Recall (label 2) = 0.862676
% F_Score (label 1) = 0.879167
% F_Score (label 2) = 0.782275