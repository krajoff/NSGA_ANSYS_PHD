%% Return stator losses, stator core area and stator voltage     
%
fid =  fopen([pwd '\populations.Baksan.1000\G4.Baksan.1000p.txt'],'r');  
datacell = textscan(fid, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f', 'Delimiter', '\t');
degMLoss = 1;
degMega = 10^6;
% The rated values
xnom = 0.153324;
ynom = 1/6316;
znom = (34837+4592+258)*(6300/6316)^2;
tnom = 0.7057;
xsubtrnom = 0.1678;
xsinom = 0.913;
x = datacell{14}./xnom; % stator core area 
y = datacell{16}./ynom; % stator voltage
z = datacell{15}./znom; % stator losses 
t = datacell{17}./tnom; % thd
xsi = datacell{18}./xsinom; % xd
%% Turn the scanned point data into a surface
k = 2;
gx = .50 : k*1e-3 : 2.50;
gy = .72 : k*2.5e-4 : 1.22;

%gx = .9 : k*.5e-3 : 1.1;
%gy = .9 : k*2.5e-4 : 1.1;

g=gridfit(x,y,xsi,gx,gy);
figure
surf(gx, gy, g)
shading interp
material dull 
grid on
grid minor
c = lines(12);
colormap(c);
colorbar
c = colorbar;
%w = c.LineWidth;
c.Position  =  [0.05 0.12 0.02 0.75];


%% Turn mesh
kg = 1;
kx = 50*kg; ky = 40*kg;
[mg, ng] = size(g);
kgx = gx(1:kx:ng); kgy = gy(1:ky:mg);
kxg = g(:, 1:kx:ng);
kyg = g(1:ky:mg, :);
hold on
surf(kgx, gy, kxg, 'EdgeColor', 'k','FaceColor','none', 'MeshStyle', 'column')
surf(gx, kgy, kyg, 'EdgeColor', 'k','FaceColor','none', 'MeshStyle', 'row')
hold off
box

%% Plot settings
line(x, y, xsi, 'marker', '.', 'markersize', 5, 'linestyle', 'none', 'Color','r');
line([0.5 1], [1 1], [1 1], 'Color', 'w', 'LineWidth', 2, 'LineStyle', '-');
line([1 1], [.5 1], [1 1], 'Color', 'w', 'LineWidth', 2, 'LineStyle', '-');
line([1 1], [1 1], [.5 1], 'Color', 'w', 'LineWidth', 2, 'LineStyle', '-');
set(gca,'CameraPosition',[1.8  0.9 1.8])
set(gca, 'outerposition',[0.025 0 1 1])
% 2.2
%xlabel('Stator core volume, p.u.', 'Position', [.1 1 -2.3]);
%ylabel('Rotor current, p.u.','Position', [2 1 -.5]);
%zlabel('Iron loss, p.u', 'Position',[-.4 1 .4]);

xlabel({'Масса сердечника';'статора, о.е.'}, 'Position', [1.7 .82 0]);
ylabel('Ток ротора, о.е.','Position', [2.1 .95 0]);
zlabel({'Потери'; 'в стали, о.е.'}, 'Position',[.5 .88 2.3]);
%zlabel({'x_d, о.е.'}, 'Position',[.5 .88 2.3]);
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
