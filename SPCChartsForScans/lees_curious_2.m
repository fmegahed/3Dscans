clc;clear;close all
load('good_run1','asdf3');
for i = 1:20
    temp=csvread(['../Phase I/' num2str(asdf3(i,2))],1,9);
    temp=abs(temp);
    temp=sort(temp);
    means(i)=mean(temp(1:floor(.99*length(temp))));
    stddevs(i)=std(temp(1:floor(.99*length(temp))));
    clear temp
end
mean_means=mean(means);
std_means=std(means);
mean_stddevs=mean(stddevs);
std_stddevs=std(stddevs);
figure(1);
plot(means);
hold on
plot([0 20],[mean_means+3*std_means mean_means+3*std_means])
plot([0 20],[mean_means-3*std_means mean_means-3*std_means])
figure(2);
plot(stddevs);
hold on
plot([0 20],[mean_stddevs+3*std_stddevs mean_stddevs+3*std_stddevs])
plot([0 20],[mean_stddevs-3*std_stddevs mean_stddevs-3*std_stddevs])
r=.2;
k_slope=3;
k_yint=3;
CL_slope=k_slope*std_means*sqrt(r/(2-r));
CL_yint=k_yint*std_stddevs*sqrt(r/(2-r));
E_slope=mean_means;
E_yint=mean_stddevs;
nof=3;
for i=1:10
    Phase_2=csvread(['../Phase I/' num2str(asdf3(i+20,2))],1,9);
    Phase_2=abs(Phase_2);
    Phase_2=sort(Phase_2);
    E_slope(i+1)=r*mean(Phase_2(1:floor(.99*length(Phase_2))))+(1-r)*E_slope(i);
    E_yint(i+1)=r*std(Phase_2(1:floor(.99*length(Phase_2))))+(1-r)*E_yint(i);
    for j=3:2:nof*2+1
        if i ==1
            figure(3);
            plot([0 18],[mean_means+CL_slope mean_means+CL_slope]);
            hold on
            plot([0 18],[mean_means-CL_slope mean_means-CL_slope]);
            figure(4);
            plot([0 18],[mean_stddevs+CL_yint mean_stddevs+CL_yint]);
            hold on
            plot([0 18],[mean_stddevs-CL_yint mean_stddevs-CL_yint]);
        end
        clear Phase_2
%         figure(j);
%         plot(i,E_slope,'*');
%         figure(j+1);
%         plot(i,E_yint,'*');
    end
end
E_slopes=ones(nof,1)*E_slope(i+1);
E_yints=ones(nof,1)*E_yint(i+1);
figure(3)
plot([0:10],E_slope);
figure(4)
plot([0:10],E_yint);
nos=[4 4 4];
for j = 1:nof
    for i = 1:nos(j)
        Phase_2=csvread(['../Phase II/Fail' num2str(j) '/' num2str(i)],1,9);
        Phase_2=abs(Phase_2);
        Phase_2=sort(Phase_2);
        E_slopes(j,i+1)=r*mean(Phase_2(1:floor(.99*length(Phase_2))))+(1-r)*E_slopes(j,i);
        E_yints(j,i+1)=r*std(Phase_2(1:floor(.99*length(Phase_2))))+(1-r)*E_yints(j,i);
        clear Phase_2 Pfitter qy
%         figure(1+(j*2));
%         plot(i+10,E_slopes(j),'*');
%         figure(2+(j*2));
%         plot(i+10,E_yints(j),'*');
    end
    figure(3)
    plot([10:14],E_slopes(j,:));
    figure(4)
    plot([10:14],E_yints(j,:));
end

