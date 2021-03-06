%% This method compares the average distance classifier
tic
%% Optional code
M = csvread('data_11x11f.csv');
M = sortrows(M,1059);
set = make_sets_11f(M,4);

%% Cross validation
per_accuracy = [];
% per_vector = 5:5:70;
per_vector = 20:20;
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
        training =  [set(:,:,mod(j,4)+1);
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
            predicted_target = average_shortest_distances(training,validation(i,1:end-1),per);
%             predicted_target = mode_shortest_distances(training,validation(i,1:end-1),per);
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
        fprintf('Recall (label 1) = %f\n',TP/(TP+FN)) % Recall = sensitive
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
toc
%% Results with average_distance1 (with a threshold)
%% Results with percentile 5th
% Accuracy = 0.811823
% Precission (label 1) = 0.848641
% Precission (label 2) = 0.725876
% Recall (label 1) = 0.878475
% Specifity = 0.672535
% F_Score (label 1) = 0.863296
% F_Score (label 2) = 0.698169
%% Results with percentile 10th
% Accuracy = 0.821083
% Precission (label 1) = 0.861022
% Precission (label 2) = 0.732758
% Recall (label 1) = 0.877001
% Specifity = 0.704225
% F_Score (label 1) = 0.868934
% F_Score (label 2) = 0.718191
%% Results with percentile 15th
% Accuracy = 0.842165
% Precission (label 1) = 0.889934
% Precission (label 2) = 0.747376
% Recall (label 1) = 0.874895
% Specifity = 0.773768
% F_Score (label 1) = 0.882341
% F_Score (label 2) = 0.760311
%% Results with percentile 20th
% Success = 0.845869
% Precission (label 1) = 0.908246
% Precission (label 2) = 0.735163
% Recall (label 1) = 0.858888
% Specifity = 0.818662
% F_Score (label 1) = 0.882877
% F_Score (label 2) = 0.774669
%% Results with percentile 25th
% Accuracy = 0.844587
% Precission (label 1) = 0.927128
% Precission (label 2) = 0.715596
% Recall (label 1) = 0.835931
% Specifity = 0.862676
% F_Score (label 1) = 0.879167
% F_Score (label 2) = 0.782275
%% Results with percentile 30th
% Accuracy = 0.841453
% Precission (label 1) = 0.936813
% Precission (label 2) = 0.702700
% Recall (label 1) = 0.820977
% Specifity = 0.884243
% F_Score (label 1) = 0.875071
% F_Score (label 2) = 0.783073
%% Results with percentile 35th
% Accuracy = 0.833761
% Precission (label 1) = 0.943112
% Precission (label 2) = 0.685496
% Recall (label 1) = 0.802654
% Specifity = 0.898768
% F_Score (label 1) = 0.867217
% F_Score (label 2) = 0.777751
%% Results with percentile 40th
% Accuracy = 0.828632
% Precission (label 1) = 0.947777
% Precission (label 2) = 0.674733
% Recall (label 1) = 0.790227
% Specifity = 0.908891
% F_Score (label 1) = 0.861816
% F_Score (label 2) = 0.774432
%% Results with percentile 45th
% Accuracy = 0.817664
% Precission (label 1) = 0.950202
% Precission (label 2) = 0.656707
% Recall (label 1) = 0.770851
% Specifity = 0.915493
% F_Score (label 1) = 0.851132
% F_Score (label 2) = 0.764737
%% Results with percentile 50th
% Accuracy = 0.810114
% Precission (label 1) = 0.955219
% Precission (label 2) = 0.643685
% Recall (label 1) = 0.754634
% Specifity = 0.926056
% F_Score (label 1) = 0.843142
% F_Score (label 2) = 0.759451
%% Results with percentile 55th
% Accuracy = 0.802564
% Precission (label 1) = 0.962311
% Precission (label 2) = 0.630950
% Recall (label 1) = 0.736942
% Specifity = 0.939701
% F_Score (label 1) = 0.834673
% F_Score (label 2) = 0.754971
%% Results with percentile 60th
% Accuracy = 0.788604
% Precission (label 1) = 0.966001
% Precission (label 2) = 0.612039
% Recall (label 1) = 0.712511
% Specifity = 0.947623
% F_Score (label 1) = 0.820106
% F_Score (label 2) = 0.743720
%% Results with percentile 65th
% Accuracy = 0.772650
% Precission (label 1) = 0.968763
% Precission (label 2) = 0.592440
% Recall (label 1) = 0.685973
% Specifity = 0.953785
% F_Score (label 1) = 0.803189
% F_Score (label 2) = 0.730880
%% Results with percentile 70th
% Accuracy = 0.754416
% Precission (label 1) = 0.969224
% Precission (label 2) = 0.572273
% Recall (label 1) = 0.657751
% Specifity = 0.956426
% F_Score (label 1) = 0.783627
% F_Score (label 2) = 0.716053
%% Results with percentile 85th
% Accuracy = 0.677350
% Precission (label 1) = 0.980168
% Precission (label 2) = 0.500914
% Recall (label 1) = 0.533698
% Specifity (label 2) = 0.977553
% F_Score (label 1) = 0.691009
% F_Score (label 2) = 0.662374
%% Results with percentile 90th
% Accuracy = 0.643732
% Precission (label 1) = 0.983934
% Precission (label 2) = 0.475736
% Recall (label 1) = 0.481045
% Specifity (label 2) = 0.983715
% F_Score (label 1) = 0.646082
% F_Score (label 2) = 0.641299
%% Results with percentile 95th
% Precission (label 1) = 0.986968
% Precission (label 2) = 0.442825
% Recall (label 1) = 0.404381
% Specifity (label 2) = 0.988996
% F_Score (label 1) = 0.573628
% F_Score (label 2) = 0.611729