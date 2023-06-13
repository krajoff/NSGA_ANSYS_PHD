%% Return stator losses, stator core area and stator voltage     
fid =  fopen([pwd '\populations.LaEska.1000\G32.LaEska.1000p.txt'],'r'); 
fstr = repmat('%f ', 1, 16);
datacell = textscan(fid, fstr, 'Delimiter', '\t');
% The rated values
xnom = 1170325;
ynom = 1/17133;
znom = 0.2614;
x = datacell{14}./xnom; % stator losses 
y = datacell{15}./ynom; % stator voltage
z = datacell{16}./znom; % THD
%% Turn the scanned point data into a surface
k = 2;
gx = .80 : k*.5e-3 : 1.3;
gy = .80 : k*.5e-3 : 1.3;

g=gridfit(x,y,z,gx,gy);
figure
surf(gx, gy, g)
shading interp
material dull 
grid on
grid minor
c = lines(9);
colormap(c);
colorbar
c = colorbar;
c.Position  =  [0.05 0.12 0.02 0.7];


%% Turn mesh
kg = 8*(2.5/k);
kx = 2.5*kg; ky = 2.5*kg;
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
line(x, y, z, 'marker', '.', 'markersize', 5, 'linestyle', 'none', 'Color','r');
line([0.5 1], [1 1], [1 1], 'Color', 'w', 'LineWidth', 2, 'LineStyle', '-');
line([1 1], [.5 1], [1 1], 'Color', 'w', 'LineWidth', 2, 'LineStyle', '-');
line([1 1], [1 1], [.5 1], 'Color', 'w', 'LineWidth', 2, 'LineStyle', '-');
set(gca,'CameraPosition',[3.5 4.0 4.4])
set(gca,'CameraPosition',[4.0 4.0 10])
%set(gca, 'outerposition',[0.025 0 1 1])
xlabel({'Потери'; 'в стали, о.е.'}, 'Position', [1.4 1.65 1.28]);
ylabel('Ток ротора, о.е.');
zlabel({'THD, о.е.'}, 'Position', [1.55 1.2 3.3]);

set(get(gca,'zlabel'), 'rotation', 0)
set(gcf,'position',[300, 300, 700, 600])

%title 'The Pareto surface in multicriteria hydro-generator parameters optimization. Generation 14'
set(get(gca,'XLabel'), 'FontSize', 12)
set(get(gca,'YLabel'), 'FontSize', 12)
set(get(gca,'ZLabel'), 'FontSize', 12)
set(get(gca, 'Title'), 'FontSize', 12)
caxis([0.2 2.0])
axis([0.8, 1.2, 0.8, 1.2, 0.2, 2.0]);

set(gca,'fontsize',12)
hold on
scatter3(1, 1, 1, 20, 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'w', 'LineWidth', 1);
l = light('Position',[1.5  1.5 10]);
