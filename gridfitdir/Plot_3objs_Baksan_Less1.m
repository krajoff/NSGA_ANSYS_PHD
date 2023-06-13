for i = 1:39
  rowprm = [];
  fid =  fopen([pwd '\populations.Baksan.750\G' num2str(i) '.Baksan.750p.txt'],'r');     
  datacell = textscan(fid, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f', 'Delimiter', '\t');
  rowprm = [rowprm; datacell];

end
%  fclose all;

%{
fid =  fopen([pwd '\populations.Baksan.750\G27.Baksan.750p.txt'],'r');    
datacell = textscan(fid, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f', 'Delimiter', '\t');
degMLoss = 1;
degMega = 10^6;
% The rated values
xnom = 0.153324;
ynom = 1/6316;
znom = (34837+4592+258)*(6300/6316)^2;



figure
grid on
grid minor

x = datacell{14}./xnom; % stator core area 
y = datacell{16}./ynom; % stator voltage
z = datacell{15}./znom; % stator losses 
line(x, y, z, 'marker', '.', 'markersize', 5, 'linestyle', 'none', 'Color','r');
line([0.5 1], [1 1], [1 1], 'Color', 'w', 'LineWidth', 2, 'LineStyle', '-');
line([1 1], [.5 1], [1 1], 'Color', 'w', 'LineWidth', 2, 'LineStyle', '-');
line([1 1], [1 1], [.5 1], 'Color', 'w', 'LineWidth', 2, 'LineStyle', '-');
set(gca,'CameraPosition',[1.8  0.9 1.8])
set(gca, 'outerposition',[0.025 0 1 1])

xlabel({'Масса сердечника';'статора, о.е.'}, 'Position', [1.7 .82 0]);
ylabel('Ток ротора, о.е.','Position', [2.1 .95 0]);
zlabel({'Потери'; 'в стали, о.е.'}, 'Position',[.5 .88 2.3]);
set(get(gca,'zlabel'), 'rotation', 0)
set(gcf,'position',[300,300,660,600])


%title 'The Pareto surface in multicriteria hydro-generator parameters optimization. Generation 14'
set(get(gca,'XLabel'), 'FontSize', 12)
set(get(gca,'YLabel'), 'FontSize', 12)
set(get(gca,'ZLabel'), 'FontSize', 12)
set(get(gca, 'Title'), 'FontSize', 12)
caxis([(0.8)^degMLoss (1.4)^degMLoss])
axis([0.5, 2.0, 0.85, 1.15, (0.0)^degMLoss, (2.0)^degMLoss]);

set(gca,'fontsize',12)
hold on
scatter3(1, 1, 1, 20, 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'w', 'LineWidth', 1);
l = light('Position',[1.2  1.3 30]);
%}