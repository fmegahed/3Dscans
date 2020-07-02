clc;clear;close all
load('good_run1','asdf3')
Phase_1=ones(52000,20)*NaN;
for i = 1:20
    temp=csvread(['../Phase I/' num2str(asdf3(i,2))],1,9);
    temp=abs(temp);
    Phase_1(1:length(temp),i)=temp;
    clear temp
end
[ro co]=size(Phase_1);
BaselineDev=reshape(Phase_1,ro*co,1);
A=[0:.0001:.99];
BaselineQuantiles=quantile(BaselineDev,A);
 for i=1:co
     RunData=Phase_1(:,i);
     RunQuantile(i,:)=quantile(RunData,A); 
     p=polyfit(BaselineQuantiles,RunQuantile(i,:),1);
     slope(i)=p(1);
     intercept(i)=p(2);
     figure(1)
        hold on
        plot(BaselineQuantiles,RunQuantile(i,:));
end
% CC=cov(RunQuantile);
% [as df]=eig(CC);
load eigendata
asdf=df(9901,9901)/sum(diag(df))
asdf2=df(9900,9900)/sum(diag(df))
for i = 1:20
    score(i)=RunQuantile(i,:)*as(:,9901);
    score2(i)=RunQuantile(i,:)*as(:,9900);
end
[mini miniindex]=min(score);
[maxi maxiindex]=max(score);
[mini2 miniindex2]=min(score2);
[maxi2 maxiindex2]=max(score2);
plot(BaselineQuantiles,RunQuantile(miniindex,:),'-.k','linewidth',3)
plot(BaselineQuantiles,RunQuantile(maxiindex,:),'k','linewidth',3)
plot(BaselineQuantiles,RunQuantile(maxiindex,:))
% plot(BaselineQuantiles,RunQuantile(miniindex2,:),'--r','linewidth',3)
% plot(BaselineQuantiles,RunQuantile(maxiindex2,:),'--k','linewidth',3)
% plot([0 .045],[0 .045],'g','linewidth',3)
% figure(2)
% plot(BaselineQuantiles,as(:,1001))
% hold on
% plot(BaselineQuantiles,as(:,1000),'r')
P(miniindex,:)
P(maxiindex,:)
P(miniindex2,:)
P(maxiindex2,:)
