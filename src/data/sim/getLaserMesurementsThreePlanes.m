function LM = getLaserMesurementsThreePlanes( ground_truth )
%GETLASERMESUREMENTSTHREEPLANES Gets measurements for the 3 planes from
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

[h,w] = size(ground_truth);
LM = zeros(h,w);

IDX=[1 1;20 5; 30 5; 49 4; 5 9; 40 15; 5 30; 30 30; 1 45; 23 46; 45 50; 
    48 48; 30 49; 30 9; 40 35; 45 35; 40 15; 45 15; 40 25; 45 25; 5 20;
    27 20];

for i=1:length(IDX)
    LM(IDX(i,2),IDX(i,1)) = ground_truth(IDX(i,2),IDX(i,1));
end


end
