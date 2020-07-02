% clc;clear;
% Delta_Big=[];
% for i = 1:50
%     load(['sims' num2str(i)])
%     for j = 1:10
%         [delta1_wid,delta1_len]=size(delta{j,1});
%         [delta2_wid,delta2_len]=size(delta{j,2});
%         Delta_Big=[Delta_Big reshape(delta{j,1},1,delta1_wid*delta1_len) reshape(delta{j,2},1,delta2_wid*delta2_len)];
%     end
%     clear delta delta1_wid delta1_len delta2_wid delta2_len
% end
% [len,wid]=size(Delta_Big);
% Delta_Big2=reshape(Delta_Big,len*wid,1);
clear P qs qx qy Deltas
qs=[0:.0001:1];
qx=quantile(Delta_Big2,qs);
pfit_counter=0;
for i = 1:50
    load(['sims' num2str(i)])
    for j=1:10
        pfit_counter=pfit_counter+1;
        [delta1_wid,delta1_len]=size(delta{j,1});
        [delta2_wid,delta2_len]=size(delta{j,2});
        Deltas=[reshape(delta{j,1},1,delta1_wid*delta1_len) reshape(delta{j,2},1,delta2_wid*delta2_len)];
        qy=quantile(Deltas,qs);
        P(pfit_counter,:)=polyfit(qx,qy,1);
%         plot(qx,qy,'*');
%         ylim([0 .025]);
%         pause(.5)
        clear Deltas qy delta1_wid delta1_len delta2_wid delta2_len
    end
    clear delta 
end
save('pfits','P')