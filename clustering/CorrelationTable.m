%corrplot(meas,'type','Kendall','testR','on')
%inc = eva.OptimalY == 1;
cls = meas(inc, :);
R = corrcoef(cls); 
%corrplot(cls, 'testR','on')
figure
heatmap(R, 'CellLabelColor', 'none', 'Colormap', parula)
caxis([-1 1])
colormap(parula); 
grid off
set(gca,'fontsize',16)
