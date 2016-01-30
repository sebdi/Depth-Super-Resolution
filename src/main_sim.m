% Simulation of Markov Random Field upsampling methods
%
% AUTHOR  Sebastian Dingler <s.dingler@gmail.com>
%         Karlsruhe Institute of Technology (KIT), Germany
%
% LICENSE github.com/sebdi/Depth-Super-Resolution/blob/master/LICENSE
%
% DATE    29.01.2016
addpath('MRF');
addpath('data/sim');
addpath('plotFncs');

%% Three planes
[depth_in, image] = simThreePlanes();
LM = getLaserMesurementsThreePlanes( depth_in );

[ImgW,ImgH,channels] = size(image);
for sigma_s=1:20
    for sigma_d=1:20
        x = mrf_diebel(LM, image,sigma_d*0.1, sigma_s*0.1);
        depth_MRF = reshape(x, ImgW, ImgH);
        plotResult(x', ImgW, ImgH, LM');
        pause(0.1);
    end
end
