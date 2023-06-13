n = 45;
m = 3;
prm = [];
g = 1:n;
%% Data
% The rated values
xnom = 1.068922;
ynom = 1/15676;
znom = (1008360+46113+17089)*(15750*ynom)^2; % = 1071562
i = 1;
j = 14;
prm = [];
gen = [];
for i = 1:n
    rowprm = [];
    fid =  fopen([pwd '\populations.Sayany.750\G' num2str(i) '.Sayany.750p.txt'],'r'); 
    datacell = textscan(fid, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f', 'Delimiter', '\t');
    datacell = cell2mat(datacell);
    gen = [gen; datacell];
    datacell(datacell(:, 14) > 2*xnom, :) = [];
    datacell(datacell(:, 14) < .5*xnom, :) = [];
    datacell(datacell(:, 15) > 2*znom, :) = [];
    datacell(datacell(:, 16) > 1.15*ynom, :) = [];
    datacell(datacell(:, 16) < .85*ynom, :) = [];
    for j = 14:16
        rowprm = [rowprm max(datacell(:,j)) min(datacell(:,j)) mean(datacell(:,j))];
    end
    prm = [prm; rowprm];
    fclose all;
end
fclose all;
%% Plot settings
figure
grid on
grid minor
k = 0;
    for i = 1:3
    k = k + 1;    
        if k <= m
            subplot(1,3,k);    
            line(g, prm(:,3*(k-1)+1:3*(k-1)+3), 'Color', 'black', 'LineWidth', 1, ...
                'LineStyle', '-', 'marker', 'o', 'markersize', 3, 'MarkerFaceColor', [0 .7 1]);
            ylabel(['Nprm ' num2str(k)]);
        end
    end    
%}