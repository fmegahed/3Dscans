clc;clear;
p0=.1;
p1=.2;
for i = 1:1000
    x=1;
    counter=0;
    S=0;
    while x==1
        as=binornd(1,p0);
        counter=counter+1;
        if as==0
            S=max([0,S+log((1-p1)/(1-p0))]);
        else
            S=max([0,S+log(p1/p0)]);
        end
        if S>2;
            x=0;
        end
    end
    RL(i)=counter;
end
ARL=mean(RL)