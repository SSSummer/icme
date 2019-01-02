function [testData]=speakerIdentifyPer_wyf(targetNum,testData,nameList,gmm, useIntGmm)
% speakerIdentify: speaker identification using GMM parameters
%	Usage: [recogRate]=speakerIdentifyPer_wyf(targetNum,testData,nameList, gmm, useIntGmm)
%       testData:  Mfcc festures from the tester
%		nameList: structure array of all speakers'name
%		gmm: GMM parameters
%		useIntGmm: use fixed-point GMM

%	Yifeng Wang, 20181101

if nargin <= 2, 
   useIntGmm = 0; % Assume FIR
end



% ====== Speaker identification using GMM parameters
speakerNum=length(nameList);
dayNum=length(testData);
for i=1:dayNum
	for j=1:length(testData(i).sentence)
		frameNum=size(testData(i).sentence(j).mfcc, 2);
		logProb=zeros(speakerNum, frameNum); 
		for k=1:speakerNum,
			logProb(k, :)=gmmEval(testData(i).sentence(j).mfcc, gmm(k).mean, gmm(k).covariance, gmm(k).weight);

        end
        

        [logProbLie,indexall]=max(logProb);
        fenbu=1:max(indexall);
        cumLogProb=histc(indexall,fenbu);
		[maxProb, index]=max(cumLogProb);
		testData(i).sentence(j).predictedSpeaker=index;
		testData(i).sentence(j).logProb=logProb;
	end
end

% ====== Compute recognition rate

for i=1:dayNum,
    rightCount=0;
    
    for j=1:length(testData(i).sentence),
        if testData(i).sentence(j).predictedSpeaker==targetNum
            rightCount=rightCount+1;
        end
    end
    allCount=length(testData(i).sentence);
    testData(i).rightRate=rightCount/allCount;
               
end
