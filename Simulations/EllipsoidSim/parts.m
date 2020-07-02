clc;clear;
fclose all;
for nparts=1:20
    counter=0;
    for i = 1:50
        for j = 1:50
            counter=1+counter;
            point(counter,:)=[normrnd(0,.025,1,1),normrnd(0,.05,1,1), normrnd(0,.075,1,1)];
        end
    end
    sparts{nparts}=[point];
end
save('parts.mat','sparts')
point_all=[point_new1;point_new2];
output = fopen('hole.wrl','w');
fprintf(output,'#VRML V2.0 utf8\n');
fprintf(output,'Viewpoint { \n');
fprintf(output,'fieldOfView .5 \n');
fprintf(output,'position 0 10 0\n');
fprintf(output,'orientation 1 1 0 0\n');
fprintf(output,'description "asdf" \n');
fprintf(output,'jump TRUE\n');
fprintf(output,'}\n');
fprintf(output,'    Background {\n');
fprintf(output,'skyColor [ 1 1 1 ] \n');
fprintf(output,'        } \n');  
for i = 1:length(point_all)  
fprintf(output,'Transform {\n');
fprintf(output,'      translation %12.8f %12.8f %12.8f\n',point_all(i,1),point_all(i,2),point_all(i,3));
fprintf(output,'      children [\n');
fprintf(output,'        Shape {\n');
fprintf(output,'          geometry Sphere {radius .05}\n');
fprintf(output,'          appearance Appearance {\n');
fprintf(output,'            material Material { diffuseColor 0 0 0 }\n');
fprintf(output,'          }\n');
fprintf(output,'        } \n');
fprintf(output,'      ] \n');
fprintf(output,'    }# end of sphere transform\n');
end
fclose all;













