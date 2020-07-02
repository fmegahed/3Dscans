function P=ourqqplot(x,y)
qs=[0:.001:1];
qx=quantile(x,qs);
qy=quantile(y,qs);
plot(qx,qy,'*');
P=polyfit(qx,qy,1);
