%clc
%clear all
n = 39;
m = 16;
prm = [];
g = 1:n;
%% Data
for i = 1:n
    rowprm = [];
    for j = 1:m
        fid =  fopen([pwd '\populations.Baksan.750\G' num2str(i) '.Baksan.750p.txt'],'r');    
        datacell = textscan(fid, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f', 'Delimiter', '\t');
        rowprm = [rowprm max(datacell{j}) min(datacell{j}) mean(datacell{j})];
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
colplt = 4;
rowplt = ceil(m/colplt);
for j = 1:colplt
    for i = 1:rowplt
    k = k + 1;    
        if k <= m
            subplot(rowplt,colplt,k);    
            line(g, prm(:,3*(k-1)+1:3*(k-1)+3), 'Color', 'black', 'LineWidth', 1, ...
                'LineStyle', '-', 'marker', 'o', 'markersize', 3, 'MarkerFaceColor', [0 .7 1]);
            ylabel(['Nprm ' num2str(k)]);
        end
    end
end
     