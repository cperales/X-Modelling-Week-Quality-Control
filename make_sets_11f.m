function subsets = make_sets_11f(complete_set,numOfPartitions,seed)
%for all the data
if (nargin==2)
    seed=1;
end

%Create a random seed 
s = RandStream('mt19937ar','Seed',seed);

classes=complete_set(:,1059);
positiveInstances=(classes==1);
negativeInstances=(classes==2);

positiveSet=complete_set(positiveInstances,:);
negativeSet=complete_set(negativeInstances,:);

positiveSet=positiveSet(1:end-mod(size(positiveSet,1),numOfPartitions),:);
negativeSet=negativeSet(1:end-mod(size(negativeSet,1),numOfPartitions),:);

positivePerSubset=size(positiveSet,1)/numOfPartitions;
negativePerSubset=size(negativeSet,1)/numOfPartitions;

subsets=zeros(positivePerSubset+negativePerSubset,1059,numOfPartitions);

randomNumbersForPos=s.rand(1,size(positiveSet,1));
[~,randomPositionsForPos]=sort(randomNumbersForPos);

randomNumbersForNeg=s.rand(1,size(negativeSet,1));
[~,randomPositionsForNeg]=sort(randomNumbersForNeg);


for idxPartition=1:numOfPartitions
    
    posFrom=1+((idxPartition-1)*positivePerSubset);
    posTo=idxPartition*positivePerSubset;
    
    posPositions=randomPositionsForPos(posFrom:posTo);
    
    subsets(1:positivePerSubset,:,idxPartition)=positiveSet(posPositions,:);
    
    posFrom=1+((idxPartition-1)*negativePerSubset);
    posTo=idxPartition*negativePerSubset;
    
    negPositions=randomPositionsForNeg(posFrom:posTo);
    
    subsets(positivePerSubset+1:end,:,idxPartition)=negativeSet(negPositions,:);
    
end




