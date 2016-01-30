function x_r = mrf_diebel(depth,image,sigma_d,sigma_s)
%MRF_diebel Implements the MRF approach from
% 
% James Diebel and Sebastian Thrun, "An application of markov random 
% fields to range sensing." NIPS. Vol. 5. 2005.
%
% AUTHOR  Sebastian Dingler <s.dingler@gmail.com>
%         Karlsruhe Institute of Technology (KIT), Germany
%
% LICENSE github.com/sebdi/Depth-Super-Resolution/blob/master/LICENSE
%
% DATE    29.01.2016

[ImgW,ImgH,channels] = size(image);
N = ImgW * ImgH;
max_z = max(max(depth));
depth = depth/max_z;

% creating the W matrix (data cost, theta_d[x,z]) & z
tic
[W,z] = dataCostMatrix(depth,sigma_d);
toc
disp('Builded data cost matrix');

% creating the S matrix (discontinuity cost, first order prior, theta_s[x,I])
tic
S = sparse(smoothnessMatrixFast(image,sigma_s));
toc
disp('Builded smoothness matrix');

%
tic
b = (W) * W' * z;
A = (S') * S + (W') * W ;

x_r = A\b; % solve sparse linear system
%x_r = cgs(A,b,1/10000000000000000000000000000000000000,2000,[],[],x_r);
%x = cgs(A,b)
%x_r = pcg(A,b);
toc

x_r = x_r * max_z;

end

