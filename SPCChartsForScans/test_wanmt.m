RandStream.setDefaultStream(RandStream('mt19937ar','seed',sum(100*clock)));
clc;clear;close all;
nob=1000;
nopib=1000;
nos=100000;
    for i = 1:nob
        x(i,:)=normrnd(0,1,1,nopib);
%           x(i,:)=unifrnd(0,10,1,nopib);
    end
    baseline=reshape(x,nob*nopib,1);
    mean1=mean(baseline);
    std1=std(baseline);
    A=0:.01:1;
    base_quantile=quantile(baseline,A);
    for i = 1:nob
        testquant=quantile(x(i,:),A);
        means(i)=mean(x(i,:));
        stds(i)=std(x(i,:));
        p(i,:)=polyfit(base_quantile,testquant,1);
        clear testquant
    end
    clear x
    mean_slopes=mean(p(:,1));
    std_slopes=std(p(:,1));
    mean_yints=mean(p(:,2));
    std_yints=std(p(:,2));
    mean_means=mean(means);
    std_means=std(means);
    mean_stds=mean(stds);
    std_stds=std(stds);
  
 % Phase 2 Simulation
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for Delta= [0 0.25 0.5 1 2 3 5 -0.25 -0.5 -1 -2 -3 -5]
    for j=1:nos
        test=[1 1];
        counter=0;
        while sum(test)~=0
            x=[normrnd(0,1,1,990) normrnd(Delta,1,1,10)];
            testquant=quantile(x,A);
            meaner=mean(x);
            stder=std(x);
            p2=polyfit(base_quantile,testquant,1);
            counter=counter+1;
            if p2(1) < mean_slopes-3.05251*std_slopes ||  p2(1) > mean_slopes+3.05251*std_slopes || p2(2) < mean_yints-3.05251*std_yints ||  p2(2) > mean_yints+3.05251*std_yints
                if test(1)==1
                    test(1)=0;
                    RL(j,1)=counter;
                end
            end
            if meaner < mean_means-3*std_means ||  meaner > mean_means+3*std_means || stder < mean_stds-3*std_stds ||  stder > mean_stds+3*std_stds
                if test(2)==1
                    test(2)=0;
                    RL(j,2)=counter;
                end
            end
        end
        clc
        mean(RL)
    end
    ARL(Delta)=mean(RL);
 end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save ('ARL','ARL');