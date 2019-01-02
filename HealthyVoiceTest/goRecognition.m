%Just run this file 'goRecognition.m',you can obtain the recognition result.
%       Calculates each speakers's recognition rate in GMM templates over
% time and save them;
%
% Loads:    
%   
%   - gmm10s  : We have trained GMM models using 10s voice data
%   - allName.mat   : A structure array of all speakers'name
%
% Outputs:
%   - The recognition result;

%	Yifeng Wang, 20181101

clear
clc


load norGmm10s16%Already trained gmm model
load allName.mat

waveDir='.\test2resHealthy';%The directory contains the mfcc parameters of each speaker we have obtained.
sentenceNumPerSpeaker=1000;				
fprintf('Get info of all wave files...\n');
resData=speakerDataRead(waveDir, sentenceNumPerSpeaker);
fprintf('Read wave files and plot the fig...\n');
typeNum=length(resData);
fprintf('Read wave files and plot the fig...\n');
for i=1:typeNum
	fprintf('%d/%d: Plot fig from  recordings by\n', i, typeNum);

    res16c=zeros(length(allName),10);
 
    perSeconDir = dir([waveDir,'\',resData(i).name,'/*.mat']);
	for j=1:length(perSeconDir), 
       targetFile=[waveDir,'\',resData(i).name,'\',perSeconDir(j).name]
       load([targetFile]);
       fprintf('Start the %d th speaker...\n',j);
       
       %% Caculate the recognition rates based on the GMM model;
       [testRes16]=speakerIdentifyPer_wyf(j,testData(),allName(), gmm());

       res16c(j,1:length(testRes16))=cat(1,testRes16.rightRate);    
 
		if j<10,
			curName=['resNor','0',num2str(j)];
		end
		if j==10,
			curName=['resNor',num2str(j)];
		end
	   
       save (curName,'testRes16');
       
    end  
end
 

