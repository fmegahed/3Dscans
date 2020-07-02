clc;clear;close all
load('good_run1','asdf3');
for i = 1:20
    temp=csvread(['../Phase I/' num2str(asdf3(i,2))],1,9);
    means(i)=mean(temp);
    stddevs(i)=std(temp);
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
    E_slope=r*mean(Phase_2)+(1-r)*E_slope;
    E_yint=r*std(Phase_2)+(1-r)*E_yint;
    for j=3:2:nof*2+1
        if i ==1
            figure(j);
            plot([0 18],[mean_means+CL_slope mean_means+CL_slope]);
            hold on
            plot([0 18],[mean_means-CL_slope mean_means-CL_slope]);
            figure(j+1);
            plot([0 18],[mean_stddevs+CL_yint mean_stddevs+CL_yint]);
            hold on
            plot([0 18],[mean_stddevs-CL_yint mean_stddevs-CL_yint]);
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
        E_slopes(j)=r*mean(Phase_2)+(1-r)*E_slopes(j);
        E_yints(j)=r*std(Phase_2)+(1-r)*E_yints(j);
        clear Phase_2 Pfitter qy
        figure(1+(j*2));
        plot(i+10,E_slopes(j),'*');
        figure(2+(j*2));
        plot(i+10,E_yints(j),'*');
    end
end

