%%
%Run this file to directly draw the results of Fig.2 as shown in the paper. Note that we have given the recognition results in this runme.m file.
%If you want to test the recognition result, you can use the goRecognition.m file.
%%
clc
clear
waveDir='.\test2resCold';%If you want to run this file, you must first load the file, see intro file.
sentenceNumPerSpeaker=1000;				% Set this to inf to get all utterance
fprintf('Get info of all wave files...\n');
resData=speakerDataRead(waveDir, sentenceNumPerSpeaker);
fprintf('Read wave files and plot the fig...\n');
typeNum=length(resData);
fprintf('Read wave files and plot the fig...\n');
for i=1:1
	fprintf('%d/%d: Plot fig from  recordings by\n', i, typeNum);
    perSeconDir = dir([waveDir,'\',resData(i).name,'/*.mat']);
    figure
	for j=1:5,%length(perSeconDir)  
       targetFile=[waveDir,'\',resData(i).name,'\',perSeconDir(j).name]
       load([targetFile]);
       fprintf('第%d个mat文件...\n',j);
       x=(1:1:length(updateRes16));
       y1=zeros(1,length(updateRes16));
       
       y2=zeros(1,length(updateRes16)); 
       for m=1:length(updateRes16),           
           y1(m)=updateRes16(m).rightRate;
           y2(m)=updateRes16(m).rightRateUpdate;
           
       end  
       
       
       ax = subplot(5,2,j);
       p(1)=plot(x,y1);
        hold on;
        p(2)=plot(x,y2);
       colormap(summer(9));
        p(1).LineWidth=2;
        p(1).Marker='s';
        p(2).LineWidth=2;
        p(2).Marker='o';
        xlim([0,10]);
        ylim([0.0,1.0])
        tick={'0' '1' '2' '3' '4' '5' '6' '7' '8' '9' '10'};
        set(gca,'XTickLabel',{'0' '1' '2' '3' '4' '5' '6' '7' '8' '9' '10'});
        if j==1,
        legend('Healthy GMM Model','Template Update Strategy');
        end
        
        ylabel('Accuracy');
        
         
        xlabel(['cS',num2str(j)]);
        
        set(gca,'FontSize',10);
    end
    
end