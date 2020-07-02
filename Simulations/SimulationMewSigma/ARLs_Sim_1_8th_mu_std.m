clc;clear;
RandStream.setDefaultStream(RandStream('mt19937ar','seed',sum(100*clock)));
c_add=[0];
b_add=[0];
a=1;
b=1.25;
c=1.5;
means=0.006751856445496;
std_means=0.003276759853654;
stds=0.004987023646961;
std_stds=0.002693514037917;
r=.2;
k_slope=2.975;
k_yint=2.975;
CL_slope=k_slope*std_means*sqrt(r/(2-r));
CL_yint=k_yint*std_stds*sqrt(r/(2-r));
ARL=[];
for runs=1:length(c_add)
    X= 0:.05:a;
    Xlen=length(X);
    Y = 0:.05:1.45;
    Ylen=length(Y);
    Z = 0:.05:1.7;
    Zlen=length(Z);
    for sims=1:250
        RL(runs,sims)=0;
        E_slope=means;
        E_yint=stds;
        while E_slope<means+CL_slope && E_slope>means-CL_slope && E_yint<stds+CL_yint && E_yint>stds-CL_yint
            RL(runs,sims)=RL(runs,sims)+1;
            P=[normrnd(a,.01*a),normrnd(b*(1+.01*b_add(runs)),.01*b),normrnd(c*(1+.01*c_add(runs)),.01*c)];
            delta=[];
            for j=1:Xlen
                for k=1:Ylen
                    u=X(j)+normrnd(0,.001);
                    v=Y(k)+normrnd(0,.001);
                    w = sqrt(P(3)^2*(1-u^2/a^2-v^2/P(2)^2))+normrnd(0,.001);
                    if isreal(w)==1
                        x=a*b*c*u*(1/(a^2*b^2*w^2 + a^2*c^2*v^2 + b^2*c^2*u^2))^(1/2);
                        y=a*b*c*v*(1/(a^2*b^2*w^2 + a^2*c^2*v^2 + b^2*c^2*u^2))^(1/2);
                        z=a*b*c*w*(1/(a^2*b^2*w^2 + a^2*c^2*v^2 + b^2*c^2*u^2))^(1/2);
                        delta=[delta sqrt((x-u)^2+(y-v)^2+(z-w)^2)];
                    end
                end
            end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            for j=1:Xlen
                for k=1:Zlen
                    u=X(j)+normrnd(0,.001);
                    w=Z(k)+normrnd(0,.001);
                    v = sqrt(P(2)^2*(1-u^2/a^2-w^2/P(3)^2))+normrnd(0,.001);
                    if isreal(v)==1
                        x=a*b*c*u*(1/(a^2*b^2*w^2 + a^2*c^2*v^2 + b^2*c^2*u^2))^(1/2);
                        y=a*b*c*v*(1/(a^2*b^2*w^2 + a^2*c^2*v^2 + b^2*c^2*u^2))^(1/2);
                        z=a*b*c*w*(1/(a^2*b^2*w^2 + a^2*c^2*v^2 + b^2*c^2*u^2))^(1/2);
                        delta=[delta sqrt((x-u)^2+(y-v)^2+(z-w)^2)];
                    end
                end
            end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
            for j=1:Zlen
                for k=1:Ylen
                    w=Z(j)+normrnd(0,.001);
                    v=Y(k)+normrnd(0,.001);
                    u = sqrt(a^2*(1-w^2/P(3)^2-v^2/P(2)^2))+normrnd(0,.001);
                    if isreal(u)==1
                        x=a*b*c*u*(1/(a^2*b^2*w^2 + a^2*c^2*v^2 + b^2*c^2*u^2))^(1/2);
                        y=a*b*c*v*(1/(a^2*b^2*w^2 + a^2*c^2*v^2 + b^2*c^2*u^2))^(1/2);
                        z=a*b*c*w*(1/(a^2*b^2*w^2 + a^2*c^2*v^2 + b^2*c^2*u^2))^(1/2);
                        delta=[delta sqrt((x-u)^2+(y-v)^2+(z-w)^2)];
                    end
                end
            end
            E_slope=r*mean(delta)+(1-r)*E_slope;
            E_yint=r*std(delta)+(1-r)*E_yint;
            clear delta
        end
        clc;
        runs
        sims
        [ARL mean(RL(runs,1:sims))]
    end
    ARL(runs)=mean(RL(runs,:));
    save('ARLs_Sim02','RL');
end