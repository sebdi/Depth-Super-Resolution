function S = smoothnessMatrixFast(image,sigma_d)
%SMOOTHNESMATRIXFAST Computes the smoothness matrix from 
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
[ImgH,ImgW,channels] = size(image);
n = ImgH * ImgW;
image = image/255;
sigma_d = 1/(sigma_d*sigma_d);
if channels>1
    right_r = bsxfun(@minus,image(1:end,1:end-1,1),image(1:end,2:end,1));
    right_g = bsxfun(@minus,image(1:end,1:end-1,2),image(1:end,2:end,2));
    right_b = bsxfun(@minus,image(1:end,1:end-1,3),image(1:end,2:end,3));
    up_r = bsxfun(@minus,image(2:end,1:end,1),image(1:end-1,1:end,1));
    up_g = bsxfun(@minus,image(2:end,1:end,2),image(1:end-1,1:end,2));
    up_b = bsxfun(@minus,image(2:end,1:end,3),image(1:end-1,1:end,3));
    left_r = bsxfun(@minus,image(1:end,2:end,1),image(1:end,1:end-1,1));
    left_g = bsxfun(@minus,image(1:end,2:end,2),image(1:end,1:end-1,2));
    left_b = bsxfun(@minus,image(1:end,2:end,3),image(1:end,1:end-1,3));
    down_r = bsxfun(@minus,image(1:end-1,1:end,1),image(2:end,1:end,1));
    down_g = bsxfun(@minus,image(1:end-1,1:end,2),image(2:end,1:end,2));
    down_b = bsxfun(@minus,image(1:end-1,1:end,3),image(2:end,1:end,3));
    norms_up = sqrt(sum([reshape(up_r',[],1) reshape(up_g',[],1) reshape(up_b',[],1)].^2,2));
    norms_down = sqrt(sum([reshape(down_r',[],1) reshape(down_g',[],1) reshape(down_b',[],1)].^2,2));
    norms_left = sqrt(sum([reshape(left_r',[],1) reshape(left_g',[],1) reshape(left_b',[],1)].^2,2));
    norms_right = sqrt(sum([reshape(right_r',[],1) reshape(right_g',[],1) reshape(right_b',[],1)].^2,2));
else
    right = bsxfun(@minus,R_ImgMat(1:end,1:end-1,1),R_ImgMat(1:end,2:end,1));
    up = bsxfun(@minus,R_ImgMat(2:end,1:end,1),R_ImgMat(1:end-1,1:end,1));
    left = bsxfun(@minus,R_ImgMat(1:end,2:end,1),R_ImgMat(1:end,1:end-1,1));
    down = bsxfun(@minus,R_ImgMat(1:end-1,1:end,1),R_ImgMat(2:end,1:end,1));
    norms_up = sqrt(sum(reshape(up',[],1).^2,2));
    norms_down = sqrt(sum(reshape(down',[],1).^2,2));
    norms_left = sqrt(sum(reshape(left',[],1).^2,2));
    norms_right = sqrt(sum(reshape(right',[],1).^2,2));
end

e_up = - sqrt(exp(-sigma_d * (norms_up.*norms_up)));
e_down = - sqrt(exp(-sigma_d * (norms_down.*norms_down)));
e_left = - sqrt(exp(-sigma_d * (norms_left.*norms_left)));
e_right = - sqrt(exp(-sigma_d * (norms_right.*norms_right)));
% reshape
e_up = [zeros(1,ImgW); reshape(e_up,ImgW,[])'];
e_down = [reshape(e_down,ImgW,[])';zeros(1,ImgW)];
e_left = [zeros(ImgH,1) reshape(e_left,[],ImgH)'];
e_right = [reshape(e_right,[],ImgH)' zeros(ImgH,1)];
% reshape
e_up = reshape(e_up',[],1);
e_down = reshape(e_down',[],1);
e_left = reshape(e_left',[],1);
e_right = reshape(e_right',[],1);
S_l = spdiags(e_left, 0, n, n);
S_r = spdiags(e_right, 0, n, n);
S_u = spdiags(e_up, 0, n, n);
S_d = spdiags(e_down, 0, n, n);
S_temp = circshift(S_l,-1,2) + circshift(S_r,1,2) + circshift(S_u,-ImgW,2) + circshift(S_d,ImgW,2);
S_sum = -sum(S_temp,2);
S = sparse(ImgH*ImgW,ImgH*ImgW);
S = spdiags(S_sum, 0, n, n) + S_temp;
end

