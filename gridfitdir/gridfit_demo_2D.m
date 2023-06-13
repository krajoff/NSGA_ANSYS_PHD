%% Return stator losses, stator core area and stator voltage     
fid =  fopen([pwd '\populations.Sayany.750\G25.Sayany.750p.txt'],'r');    
datacell = textscan(fid, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f', 'Delimiter', '\t');
degMLoss = 1;
degMega = 10^6;
% The rated values
xnom = 1.068922;
ynom = 1/15676;
znom = (1008360+46113+17089); % = 1071562
x = datacell{14}./xnom; % stator core area 
y = datacell{16}./ynom; % stator voltage
z = datacell{15}./znom; % stator losses 
%{
%% Turn the scanned point data into a surface
k = 2;
gx = .50 : k*1e-3 : 2.50;
gy = .72 : k*2.5e-4 : 1.22;

%gx = .9 : k*.5e-3 : 1.1;
%gy = .9 : k*2.5e-4 : 1.1;

g=gridfit(x,y,z,gx,gy);
figure
surf(gx, gy, g)
shading interp
material dull 
grid on
grid minor
c = lines(16);
colormap(c);
colorbar
c = colorbar;
%w = c.LineWidth;
c.Position  =  [0.04 0.12 0.02 0.75];


%% Turn mesh
kx = 50*1; ky = 40*1;
[mg, ng] = size(g);
kgx = gx(1:kx:ng); kgy = gy(1:ky:mg);
kxg = g(:, 1:kx:ng);
kyg = g(1:ky:mg, :);
hold on
surf(kgx, gy, kxg, 'EdgeColor', 'k','FaceColor','none', 'MeshStyle', 'column')
surf(gx, kgy, kyg, 'EdgeColor', 'k','FaceColor','none', 'MeshStyle', 'row')
hold off
%}

figure

grid on
grid minor
%c = lines(16);
%colormap(c);
%colorbar
%c = colorbar;
%w = c.LineWidth;
%c.Position  =  [0.04 0.12 0.02 0.75];
%% Plot settings
line(x, y, z, 'marker', '.', 'markersize', 5, 'linestyle', 'none', 'Color','black');
%line([0.5 1], [1 1], [1 1], 'Color', 'r', 'LineWidth', 2, 'LineStyle', '-');
%line([1 1], [.5 1], [1 1], 'Color', 'r', 'LineWidth', 2, 'LineStyle', '-');
%line([1 1], [1 1], [.5 1], 'Color', 'r', 'LineWidth', 2, 'LineStyle', '-');
set(gca,'CameraPosition',[1.8  0.90 2.2])
xlabel('Stator core volume, p.u.');
ylabel('Rotor current, p.u.');
zlabel('Iron loss, p.u', 'Position',[0 .85 2.05]);
set(get(gca,'zlabel'), 'rotation', 0)

title 'The Pareto surface in multicriteria hydro-generator parameters optimization. Generation 20' 
set(get(gca,'XLabel'), 'FontSize', 16)
set(get(gca,'YLabel'), 'FontSize', 16)
set(get(gca,'ZLabel'), 'FontSize', 16)
set(get(gca, 'Title'), 'FontSize', 16)
caxis([(0.7)^degMLoss (1.5)^degMLoss])
%axis([.9, 1.1, .9, 1.1, (0.5)^degMLoss, (1.3)^degMLoss]);
axis([0.5, 2.0, 0.85, 1.15, (0.0)^degMLoss, (2)^degMLoss]);

set(gca,'fontsize',20)
hold on
scatter3(1, 1, 1, 20, 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'w', 'LineWidth', 1);
l = light('Position',[1.2  1.3 25]);
