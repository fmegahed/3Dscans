RandStream.setDefaultStream(RandStream('mt19937ar','seed',sum(100*clock)));
clc;clear;close all;
% nob=1000;
% nopib=1000;
% nos=10000;
%     for i = 1:nob
%         x(i,:)=normrnd(0,1,1,nopib);
% %           x(i,:)=unifrnd(0,10,1,nopib);
%     end
%     baseline=reshape(x,nob*nopib,1);
%     mean1=mean(baseline);
%     std1=std(baseline);
%     A=0:.001:1;
%     base_quantile=quantile(baseline,A);
%     for i = 1:nob
%         testquant=quantile(x(i,:),A);
%         means(i)=mean(x(i,:));
%         stds(i)=std(x(i,:));
%         p(i,:)=polyfit(base_quantile,testquant,1);
%         clear testquant
%     end
%     clear x
%     mean_slopes=mean(p(:,1));
%     std_slopes=std(p(:,1));
%     mean_yints=mean(p(:,2));
%     std_yints=std(p(:,2));
%     mean_means=mean(means);
%     std_means=std(means);
%     mean_stds=mean(stds);
%     std_stds=std(stds);
%     save('sim_data')
r=.2;
k_slope=3;
k_yints=3;
load sim_data
Delta= [5 3 2 1.5 1 0.75 0.5 0.25];
nos=50000;
for Fadel= 1:length(Delta)
    for j=1:nos
        test=1;
        counter=0;
        E_slopes=mean_slopes;
        E_yints=mean_yints;
        while test==1
            x=[normrnd(0,1,1,990) normrnd(Delta(Fadel),1,1,10)];
            x=abs(x);
            testquant=quantile(x,A);
            p2=polyfit(base_quantile,testquant,1);
            counter=counter+1;
            E_slopes=r*p2(1)+(1-r)*E_slopes;
            E_yints=r*p2(2)+(1-r)*E_yints;
            if E_slopes < mean_slopes-k_slope*std_slopes*sqrt(r/(2-r)) ||  E_slopes > mean_slopes+k_slope*std_slopes*sqrt(r/(2-r)) || E_yints < mean_yints-k_yints*std_yints*sqrt(r/(2-r)) ||  E_yints > mean_yints+k_yints*std_yints*sqrt(r/(2-r))
                test=0;
                RL(j)=counter;
            end
        end
        clc
        mean(RL)
        Fadel
        j
    end
ARL(Fadel,:)=mean(RL);
clear RL
end
save ('ARLMeanShiftTenPoints', 'ARL', 'Delta')
