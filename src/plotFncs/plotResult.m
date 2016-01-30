function plotResult(x,ImgW,ImgH,LM_P)
%PLOTRESULT Plots the measurements and the results
%
% AUTHOR  Sebastian Dingler <s.dingler@gmail.com>
%         Karlsruhe Institute of Technology (KIT), Germany
%
% LICENSE github.com/sebdi/Depth-Super-Resolution/blob/master/LICENSE
%
% DATE    29.01.2016
clf;
[X_plot,Y_plot] = meshgrid(1:ImgW,1:ImgH);
Z_plot = reshape(x,ImgH,ImgW);
h=surface(X_plot,Y_plot,Z_plot);
hold on;
grid on;
[x,y]=find(LM_P>0);
plot3(y,x,LM_P(sub2ind(size(LM_P),x,y)),'rO','markerfacecolor','r');
view(315, 25);
%zlim([0 300]);
xlabel('u');
ylabel('v');
zlabel('depth');
%set(h,'edgecolor','none');
end

