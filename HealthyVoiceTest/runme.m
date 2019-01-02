%%
%Run this file to directly draw the results of Fig.2 as shown in the paper. Note that we have given the recognition results in this runme.m file.
%If you want to test the recognition result, you can use the goRecognition.m file.

clc
clear
waveDir='.\test2resHealthy';
sentenceNumPerSpeaker=1000;				e
fprintf('Get info of all wave files...\n');
resData=speakerDataRead(waveDir, sentenceNumPerSpeaker);
fprintf('Read wave files and plot the fig...\n');
typeNum=length(resData);
fprintf('Read wave files and plot the fig...\n');
for i=1:1
	fprintf('%d/%d: Plot fig from  recordings by\n', i, typeNum);
    perSeconDir = dir([waveDir,'\',resData(i).name,'/*.mat']);
    figure
	for j=1:length(perSeconDir)  
       targetFile=[waveDir,'\',resData(i).name,'\',perSeconDir(j).name]
       load([targetFile]);
       fprintf('%d th mat file...\n',j);
       x=(1:1:length(testRes16));
       y=zeros(1,length(testRes16));
       for m=1:length(testRes16),           
           y(m)=testRes16(m).rightRate;
       end   
       
       ax = subplot(2,4,j);
       bar(x,y);
       colormap(summer(9));
       xlabel(['hS',num2str(j)]);
        ylabel('Recognition rate ');


        xlim([0,11]);
        ylim([0.8,1.0])
        tick={'1' '2' '3' '4' '5' '6' '7' '8' '9' '10'};
        set(gca,'XTickLabel',{ '1' '2' '3' '4' '5' '6' '7' '8' '9' '10'});
        %legend('16c');
        set(gca,'FontSize',16);
    end
    
end