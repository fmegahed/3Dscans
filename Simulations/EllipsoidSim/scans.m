clc;clear;
load parts.mat
peeps_var=[.05,.05,.5];
for peeps=1:3
    for ppp=1:2
        for part=1:20
            for i=1:2500
                if peeps==3
                    partspeeps(i)=(sparts{part}(i,:)+unifrnd(0,.25,1,3))*[1 1 1]';
                else
                partspeeps(i)=(sparts{part}(i,:)+normrnd(0,peeps_var(peeps),1,3))*[1 1 1]';
                end
            end
            scanned{peeps,ppp,part}=partspeeps;
        end
    end
end
save('scanned.mat','scanned')