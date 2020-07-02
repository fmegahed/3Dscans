for i = 1:10000
    r=i/100;
    x(i)=cos(i)*r;
    y(i)=sin(i)*r;
    plot(x,y);
    pause(.1);
end