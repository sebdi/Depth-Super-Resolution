function [depth image] = simThreePlanes()
%SIMTHREEPLANES Simulates the 3 planes from
% 
% Alastair Harrison and Paul Newman, "Image and Sparse Laser Fusion for 
% Dense Scene Reconstruction",
% Field and Service Robotics, Springer Berlin Heidelberg, pp. 219-228, 2010.
%
% AUTHOR  Sebastian Dingler <s.dingler@gmail.com>
%         Karlsruhe Institute of Technology (KIT), Germany
%
% LICENSE github.com/sebdi/Depth-Super-Resolution/blob/master/LICENSE
%
% DATE    29.01.2016

[X] = meshgrid(1:50);
size = length(X);
depth = zeros(size,size);
planes = zeros(size,size);

% generate 3 planes
depth(1:15,1:35) = 25;
planes(1:15,1:35) = 1;
depth(1:50,36:50) = 40;
planes(1:50,36:50) = 2;
for v=16:50
   for u=1:35
       depth(v,u) = v;
       planes(v,u) = 3;
   end
end

% generate 3 different colors
image(:,:,1) = 255*(planes==1);
image(:,:,2) = 255*(planes==1);
image(:,:,3) = 0*(planes==1);
image(:,:,1) = image(:,:,1) + 255*(planes==2);
image(:,:,2) = image(:,:,2) + 0*(planes==2);
image(:,:,3) = image(:,:,3) + 0*(planes==2);
image(:,:,1) = image(:,:,1) + 0*(planes==3);
image(:,:,2) = image(:,:,2) + 0*(planes==3);
image(:,:,3) = image(:,:,3) + 255*(planes==3);

%% uncomment for displaying and saving

%surface(x,y,depth);
%grid on;
%imshow(image/255);
 
%imwrite(depth/max(max(depth)),'3_planes_depth.png');
%imwrite(image/255,'3_planes_color.png');
end