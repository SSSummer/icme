%Just run this file 'runMe',you can obtain the result.
%       Calculates each speakers's recognition rate in different templates over
% time and plot all results;
%
% Loads:    
%   
%   - gmm2s/5s/10s  : We have trained GMM models using 2s(5s/10s) voice data
%   - allName.mat   : A structure array of all speakers'name
%
% Outputs:
%   - The figure of the mean recognition rate based on the different model(gmm2s~gmm10s);

%	Yifeng Wang, 20181101

clear
clc




load allName.mat

waveDir='.\test2resCold';%The directory contains the mfcc parameters of each speaker we have obtained.
sentenceNumPerSpeaker=1000;				
fprintf('Get info of all wave files...\n');
resData=speakerDataRead(waveDir, sentenceNumPerSpeaker);
fprintf('Read wave files and plot the fig...\n');
typeNum=length(resData);
fprintf('Read wave files and plot the fig...\n');
for i=1:1,%typeNum
	fprintf('%d/%d: Plot fig from  recordings by\n', i, typeNum);

    res16c=zeros(length(allName),10);

    
    perSeconDir = dir([waveDir,'\',resData(i).name,'/*.mat']);
	for j=1:length(perSeconDir), 
       targetFile=[waveDir,'\',resData(i).name,'\',perSeconDir(j).name]
       load([targetFile]);
       fprintf('Start the %d th speaker...\n',j);
       
       %% Caculate the recognition rates based on the different model(gmm2s~gmm10s);
       [updateRes16]=speakerIdentifyUpdate(j,updateRes16(),allName());
       
       if j<=9,
        curName=['updateRes','0',num2str(j)];
       
       end
       if j==10,
        curName=['updateRes',num2str(j)];
       end
        save (curName,'updateRes'); 
       
    end  
end


