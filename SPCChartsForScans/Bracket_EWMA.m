clc;clear;close all
asdf=unifrnd(0,1,1,30);
asdf2=[asdf;[1:30]];
asdf3=sortrows(asdf2');
load('good_run1','asdf3');
Phase_1=ones(50000,20)*NaN;
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
     RunQuantile=quantile(RunData,A); 
     p=polyfit(BaselineQuantiles,RunQuantile,1);
     slope(i)=p(1);
     intercept(i)=p(2);
 end
mean_slope=mean(slope);
std_slope=std(slope);
mean_yint=mean(intercept);
std_yint=std(intercept);
figure(1);
plot(slope);
hold on
plot([0 20],[mean_slope+3*std_slope mean_slope+3*std_slope])
plot([0 20],[mean_slope-3*std_slope mean_slope-3*std_slope])
figure(2);
plot(intercept);
hold on
plot([0 20],[mean_yint+3*std_yint mean_yint+3*std_yint])
plot([0 20],[mean_yint-3*std_yint mean_yint-3*std_yint])
r=.2;
k_slope=3;
k_yint=3;
CL_slope=k_slope*std_slope*sqrt(r/(2-r));
CL_yint=k_yint*std_yint*sqrt(r/(2-r));
E_slope=mean_slope;
E_yint=mean_yint;
nof=3;
for i=1:10
    Phase_2=csvread(['../Phase I/' num2str(asdf3(i+20,2))],1,9);
    Phase_2=abs(Phase_2);
    qy=quantile(Phase_2,A);
    [Pfitter]=polyfit(BaselineQuantiles,qy,1);
    E_slope=r*Pfitter(1)+(1-r)*E_slope;
    slopes(i)=Pfitter(1);
    E_yint=r*Pfitter(2)+(1-r)*E_yint;
    clear Phase_2 Pfitter qy
    for j=3:2:nof*2+1
        if i ==1
            figure(j);
            plot([0 18],[mean_slope+CL_slope mean_slope+CL_slope]);
            hold on
            plot([0 18],[mean_slope-CL_slope mean_slope-CL_slope]);
            figure(j+1);
            plot([0 18],[mean_yint+CL_yint mean_yint+CL_yint]);
            hold on
            plot([0 18],[mean_yint-CL_yint mean_yint-CL_yint]);
        end
        figure(j);
        plot(i,E_slope,'*');
        figure(j+1);
        plot(i,E_yint,'*');
    end
end
E_slopes=ones(nof,1)*E_slope;
E_yints=ones(nof,1)*E_yint;
nos=[8 8 4];
for j = 1:nof
    for i = 1:nos(j)
        Phase_2=csvread(['../Phase II/Fail' num2str(j) '/' num2str(i)],1,9);
        Phase_2=abs(Phase_2);
        qy=quantile(Phase_2,A);
        [Pfitter]=polyfit(BaselineQuantiles,qy,1);
        E_slopes(j)=r*Pfitter(1)+(1-r)*E_slopes(j);
        E_yints(j)=r*Pfitter(2)+(1-r)*E_yints(j);
        clear Phase_2 Pfitter qy
        figure(1+(j*2));
        plot(i+10,E_slopes(j),'*');
        figure(2+(j*2));
        plot(i+10,E_yints(j),'*');
    end
end

