function [testData]=speakerIdentifyUpdate(targetNum,testData,nameList,useIntGmm)
% speakerIdentify: speaker identification using GMM parameters
%	Usage: [recogRate]=speakerIdentifyUpdate(targetNum,testData,nameList, gmm, useIntGmm)
%       testData:  Mfcc festures from the tester
%		nameList: structure array of all speakers'name
%		gmm: GMM parameters
%		useIntGmm: use fixed-point GMM

%	Yifeng Wang, 20181101

if nargin <= 2, 
   useIntGmm = 0; % Assume FIR
end

load healGmm10s16.mat%Template based on healthy speech from cold speakers
load coldGmm10supdate.mat%%Template based on cold speech from cold speakers

% ====== Speaker identification using GMM parameters
speakerNum=length(nameList);
dayNum=length(testData);
for i=1:dayNum
	for j=1:length(testData(i).sentence)
        
		frameNum=size(testData(i).sentence(j).mfcc, 2);
		logProb=zeros(speakerNum, frameNum); 
        if testData(i).sentence(j).cOh==1,
            for k=1:speakerNum,
                logProb(k, :)=gmmEval(testData(i).sentence(j).mfcc, gmmCold16(k).mean, gmmCold16(k).covariance, gmmCold16(k).weight);
            end            
            [logProbLie,indexall]=max(logProb);
            fenbu=1:max(indexall);
            cumLogProb=histc(indexall,fenbu);
            [maxProb, index]=max(cumLogProb);
            testData(i).sentence(j).predScold=index;
            testData(i).sentence(j).predSheal=0;
            testData(i).sentence(j).logProb=logProb;
  
        end
        if testData(i).sentence(j).cOh==2,
            for k=1:speakerNum,
                logProb(k, :)=gmmEval(testData(i).sentence(j).mfcc, gmmHeal16(k).mean, gmmHeal16(k).covariance, gmmHeal16(k).weight);
            end
            
            [logProbLie,indexall]=max(logProb);
            fenbu=1:max(indexall);
            cumLogProb=histc(indexall,fenbu);
            [maxProb, index]=max(cumLogProb);
            testData(i).sentence(j).predScold=0;
            testData(i).sentence(j).predSheal=index;
            testData(i).sentence(j).logProb=logProb;
        end
        
	end
end

% ====== Compute recognition rate

for i=1:dayNum,
    rightCount=0;
    
    for j=1:length(testData(i).sentence),
        if testData(i).sentence(j).predScold==targetNum || testData(i).sentence(j).predSheal==targetNum,
            rightCount=rightCount+1;
        end
    end
    allCount=length(testData(i).sentence);
    testData(i).rightRateUpdate=rightCount/allCount;
               
end
