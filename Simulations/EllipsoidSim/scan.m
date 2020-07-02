clc;clear;
delete scan.wrl
load scan.mat
[x y]=size(scan);
output = fopen('scan2.wrl','w');
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
for i = 1:x
fprintf(output,'Transform {\n');
fprintf(output,'      translation %12.8f %12.8f %12.8f\n',scan(i,1),scan(i,2),scan(i,3));
fprintf(output,'      children [\n');
fprintf(output,'        Shape {\n');
fprintf(output,'          geometry Sphere {radius .005}\n');
fprintf(output,'          appearance Appearance {\n');
fprintf(output,'            material Material { diffuseColor 0 0 0 }\n');
fprintf(output,'          }\n');
fprintf(output,'        } \n');
fprintf(output,'      ] \n');
fprintf(output,'    }# end of sphere transform\n');
end
fclose all;













