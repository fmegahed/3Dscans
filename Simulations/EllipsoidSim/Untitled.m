clc;clear;
load asdf.mat
counter=0;
for i =1:length(asdf)
if abs(asdf(i))<.1
counter=counter+1;
asdf2(counter)=asdf(i);
end
end
hist(asdf2,15)