clc;clear;
[X,Y] = meshgrid(-1.4:.05:1.4,-2:.05:2);
[len,wid]=size(X);
file_counter=0;
for file_counter=1:50
    for i= 1:10
        real_counter=0;
        for j=1:len
            for k=1:wid
                u=X(j,k)+normrnd(0,.001);
                v=Y(j,k)+normrnd(0,.001);
                u2=X(j,k)+normrnd(0,.001);
                v2=Y(j,k)+normrnd(0,.001);
                P=[normrnd(1,.01),normrnd(2,.02),normrnd(3,.03)];
                w = sqrt(P(3)^2*(1-u^2/P(1)-v^2/P(2)));
                w2 = -sqrt(P(3)^2*(1-u2^2/P(1)-v2^2/P(2)));
                if isreal(w)==1 && isreal(w2)==1
                    real_counter=real_counter+1;
                    x=P(1)*P(2)*P(3)*u*(1/(P(1)^2*P(2)^2*w^2 + P(1)^2*P(3)^2*v^2 + P(2)^2*P(3)^2*u^2))^(1/2);
                    y=P(1)*P(2)*P(3)*v*(1/(P(1)^2*P(2)^2*w^2 + P(1)^2*P(3)^2*v^2 + P(2)^2*P(3)^2*u^2))^(1/2);
                    z=P(1)*P(2)*P(3)*w*(1/(P(1)^2*P(2)^2*w^2 + P(1)^2*P(3)^2*v^2 + P(2)^2*P(3)^2*u^2))^(1/2);
                    x2=P(1)*P(2)*P(3)*u2*(1/(P(1)^2*P(2)^2*w2^2 + P(1)^2*P(3)^2*v2^2 + P(2)^2*P(3)^2*u2^2))^(1/2);
                    y2=P(1)*P(2)*P(3)*v2*(1/(P(1)^2*P(2)^2*w2^2 + P(1)^2*P(3)^2*v2^2 + P(2)^2*P(3)^2*u2^2))^(1/2);
                    z2=P(1)*P(2)*P(3)*w2*(1/(P(1)^2*P(2)^2*w2^2 + P(1)^2*P(3)^2*v2^2 + P(2)^2*P(3)^2*u2^2))^(1/2);
                    delta{i,1}(j,k)=min([sqrt((x2-u2)^2+(y2-v2)^2+(z2-w2)^2), sqrt((-x2-u2)^2+(y2-v2)^2+(z2-w2)^2),...
                      sqrt((x2-u2)^2+(y2-v2)^2+(-z2-w2)^2), sqrt((-x2-u2)^2+(y2-v2)^2+(-z2-w2)^2),...
                      sqrt((x2-u2)^2+(-y2-v2)^2+(z2-w2)^2), sqrt((-x2-u2)^2+(-y2-v2)^2+(z2-w2)^2),...
                      sqrt((x2-u2)^2+(-y2-v2)^2+(-z2-w2)^2), sqrt((-x2-u2)^2+(-y2-v2)^2+(-z2-w2)^2)]);
                    delta{i,2}(j,k)=min([sqrt((x-u)^2+(y-v)^2+(z-w)^2), sqrt((-x-u)^2+(y-v)^2+(z-w)^2),...
                                      sqrt((x-u)^2+(y-v)^2+(-z-w)^2), sqrt((-x-u)^2+(y-v)^2+(-z-w)^2),...
                                      sqrt((x-u)^2+(-y-v)^2+(z-w)^2), sqrt((-x-u)^2+(-y-v)^2+(z-w)^2),...
                                      sqrt((x-u)^2+(-y-v)^2+(-z-w)^2), sqrt((-x-u)^2+(-y-v)^2+(-z-w)^2)]);
                    clear  X_act Y_act Z_act A res1 H_temp counter H
                end
            end
        end
    end
    save(['sims' num2str(file_counter)],'delta')
    clear delta
end