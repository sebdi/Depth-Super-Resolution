function [W,z] = dataCostMatrix(depth,sigma_d)
%DATACOSTMATRIX Computes the data cost matrix from
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
[ImgW,ImgH] = size(depth);
n = ImgW * ImgH;
W = sparse(n,n);
d = reshape(depth',[],1);
W = spdiags(d*sigma_d, 0, n, n);
z = d;
end

