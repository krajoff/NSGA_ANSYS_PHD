clear all; close all
%folder = 'H:\Matlab_NSGAII_ES_01.06.2020_All_Cases\gridfitdir.17.10.2020';
folder = '..\gridfitdir.17.10.2020';
genNum = 10;
%IntData = struct('hpp', 'Sayany', 'gen', 46, ...
%          'value', [1.068922; 1071562; 1/15676], ...
%          'ord', [1; 3; 2], ...
%          'lub', [11000 12100; 12550 13500; 2700 2800; 21 37; 25 35; 2000 2160; ...
%          28 32; 4 10; 600 650; 0 35; 60 90; 450 530; 4 6], ...
%          'axyz', [0, 2.5, 0, 5, .6, 1.6], ...
%          'bxyz', [.5, 1, .2], ...
%          'ref', [11850; 12850; 2750; 30.2; 30; 2079.2; 30.4; 7.8; 620; 30; 75; 490; 5], ...
%          'pop', '750', 'x',{'Масса сердечника статора, о.е.'}, 'y',{'Ток ротора, о.е.'}, ...
%          'z',{'Потери в стали, о.е.'}, 'geo', [504; 74.6*16.9; (14.6+6.3+9.1+16); 13.3], ...
%           'rmv', [4, 0, 4], 'per', [2 98]);
IntData = struct('hpp', 'Baksan', 'gen', 40, ...
          'value', [0.153324; (34837+4592+258)*(6300/6316)^2; 1/6316; 0.913], ...
          'ord', [1; 3; 2; 4], ...
          'lub', [2300 2700; 100 500; 725 775; 10 25; 10 16; 900 1050; 10 18; ...
          4 10; 460 490; 0 20; 40 80; 300 350; 4 6], ...
          'axyz', [0, 4, 0.6, 1.4, 0.5, 2.5], ...
          'bxyz', [1, .2, .5], ...
          'ref', [2500; 194; 750; 16.6; 13; 970; 14.4; 9.8; 475; 20; 65; 315; 3], ...
          'pop', '750', 'x',{'Масса сердечника статора, о.е.'}, 'y',{'Ток ротора, о.е.'}, ...
          'z',{'Потери в стали, о.е.'}, 'geo', [180; 52*11.5; (6.9+2.95+5.95+6); 5.1], ...
          'rmv', [4, 0, 4], 'per', [1 99]);
%IntData = struct('hpp', 'LaEska', 'gen', 33, ...
%           'value', [1170325; 1/17133; 0.2614; 4.7006e+10], ...
%           'ord', [1; 2; 3], ...
%           'lub', [9800 11500; 290 400; 2950 3050; 15 25; 20 30; 1700 1900; 14 19; ...
%           4 10; 495 535; 0 20; 55 85; 2 75; 3 6], ...
%           'axyz', [0.8, 1.2, 0.8, 1.2, 0.25, 1.75], ...
%           'bxyz', [.1, .1, .25], ...
%           'ref', [10840; 306.7; 3000; 19; 25; 1780.8; 16.4; 8; 515; 0; 70; 59; 4], ...
%           'pop', '1000', 'x',{'Потери в стали, о.е.'}, 'z',{'THD, о.е.'}, ...
%           'y',{'Ток ротора, о.е.'}, 'geo', [648; 10.9*72.6; (12.9+6.45+5.75+12+1); 8.1], ...
%           'rmv', [4, 0, 4], 'per', [1 99]);
fstr = repmat('%f ', 1, 16);
%% Read data
folderPath = fullfile([folder '\populations.' IntData.hpp '.' IntData.pop '\']);
data = [];
for i = 1 : genNum
    filePath = fullfile([folderPath 'G' num2str(IntData.gen-i) '.' IntData.hpp '.' IntData.pop 'p.txt']);
    fid =  fopen(filePath, 'r');
    datacell = textscan(fid, fstr, 'Delimiter', '\t');
    datacell = cell2mat(datacell);    
    data = [data; datacell];
    fclose all;
end
meas = data(:, 1:13);
[rows, columns] = size(meas);
%hs012 = round(2*52*11.5./(meas(:,4)-5.1)+6.9+2.95+5.95+(5.5+.5));
%meas(:,2) = meas(:,1)+2.*meas(:,2)+2.*hs012;
species = data(:, 14:16);
%% Clustering data
rng('default')
loops = 1;
InspectedK = 10;
criterion = zeros(loops,InspectedK);
for i=1:loops
    %eva = evalclusters(meas, 'gmdistribution', 'CalinskiHarabasz', 'KList', 1:5);
    eva = evalclusters(meas, 'kmeans', 'CalinskiHarabasz', 'KList', 1:InspectedK);
    criterion(i,:) = eva.CriterionValues;
end    
plot(1:InspectedK,mean(criterion,1))
%sidx = categorical(flipud(species));
%% 3D-plot of fitness-function
hs012 = round(2*IntData.geo(2)*(meas(:,4)-IntData.geo(4)).^-1+IntData.geo(3));
mass = ((meas(:,1)+2*meas(:,2)+2*hs012).^2-meas(:,1).^2-IntData.geo(1)*hs012.*meas(:,4)).*meas(:,3)*pi/4;
PlotClusters(cat(2, species(:,IntData.ord(1))/IntData.value(IntData.ord(1)), ...
                    species(:,IntData.ord(2))/IntData.value(IntData.ord(2)), ...
                    species(:,IntData.ord(3))/IntData.value(IntData.ord(3))), ...
                    eva.OptimalY)                     
set(gca,'XTick',IntData.axyz(1):IntData.bxyz(1):IntData.axyz(2));
set(gca,'YTick',IntData.axyz(3):IntData.bxyz(2):IntData.axyz(4));
set(gca,'ZTick',IntData.axyz(5):IntData.bxyz(3):IntData.axyz(6));
axis(IntData.axyz);
view([135 16])
hold on
% Black base-hydrogenerator and its lines
scatter3(1, 1, 1, 15, 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'LineWidth', 1);
line([0.85 1], [1 1], [1 1], 'Color', 'k', 'LineWidth', 2, 'LineStyle', '-');
line([1 1], [.85 1], [1 1], 'Color', 'k', 'LineWidth', 2, 'LineStyle', '-');
line([1 1], [1 1], [.85 1], 'Color', 'k', 'LineWidth', 2, 'LineStyle', '-');
saveas(gcf, [IntData.hpp '_Clustering.png'])
hold off
%% 2D-plot of h\h-parameters
%{
figure('Name', 'Remove outliers by percentiles')
np = length(IntData.lub);
ncl = eva.OptimalK-1;
grp = cell(1, eva.OptimalK);
criteria = cell(1, eva.OptimalK);
for i = 1:eva.OptimalK
    inc = eva.OptimalY == i;
    
    grp{i} = meas(inc, :);
    [grp{i}, TF] = rmoutliers(grp{i}, 'percentiles', IntData.per); % detect and remove outliers
    criteria{i} = species(inc, :);
    criteria{i} = criteria{i}(~TF, :);

% leaved points   
    numrow = length(grp{i});
    dlt = repmat((IntData.lub(:,2)-IntData.lub(:,1))', numrow, 1);
    drmn = repmat(IntData.lub(:,1)', numrow, 1);
    rmn = rdivide(grp{i}-drmn, dlt);

% removed outliers    
    rmvgrp{i} = meas(inc, :);
    rmvgrp{i} = rmvgrp{i}(TF, :);
    numrmv = length(rmvgrp{i});
    dlt = repmat((IntData.lub(:,2)-IntData.lub(:,1))', numrmv, 1);
    drmn = repmat(IntData.lub(:,1)', numrmv, 1);
    rmv = rdivide(rmvgrp{i}-drmn, dlt);
    rmv = rmv(1:numrmv,:);
    ClusterOne= data(inc, :);
    
    xpr = 1:np;
    xrp = repmat(xpr, numrow, 1);
    xrp = xrp - (ncl-1)/7 + i/7;
    clr = {[0 0.45 0.74], [0.85 0.33 0.1], [0.93 0.69 0.13], ...
           [0.49 0.18 0.56], [0.47 0.67 0.19]}; % blue, red, yellow, puple and green
       
    xrv = xrp(1:numrmv,:)'; 
    plot(xrv, rmv', 'LineStyle', 'none', 'Marker', '.', 'MarkerEdgeColor', [0 0 0], 'MarkerSize', 10); 
    hold on
    plot(xrp', rmn', 'LineStyle', 'none', 'Marker', '.', 'MarkerEdgeColor', clr{i}, 'MarkerSize', 12); 
end
nmpr = {'D_g', 'D_y', 'l_1' , 'b_{s2}', '\delta', 'R_p', 'd_d', 'r_{ld}', ...
        'w_{pmn}', 'w_{pmj}', 'h_{ps}', 'b_{p}', 'b_{so}'};
set(gca, 'xtick', 1:np, 'xticklabel', nmpr, 'ytick', 0:.1:1, 'FontSize', 12)
saveas(gcf, [IntData.hpp '_RangParameters.png'])
hold off
%}
%{
%% Correlation matrix and condition number of clusters
nmr = {'D_g', 'D_y', 'l_1' , 'b_s_2', 'gap', 'R_p', 'd_d', 'r_l_d', ...
        'w_p_m_n', 'w_p_m_j', 'h_p_s', 'b_p', 'b_s_o'};
CondInd = ones(1, eva.OptimalK);
VIF = ones(eva.OptimalK, columns);
grpOne = grp;
for i = 1:eva.OptimalK
    inc = eva.OptimalY == i;
%   grp{i} = meas(inc, :);
    grpOne{i} = [ones(size(grp{i}(:,1))) grp{i}];
    figure('Name', ['Correlation Plot For Cluster ' int2str(i)]);
    [R{i}, PValue{i}] = corrplot(grp{i}, 'testR','on', 'type', 'Spearman', 'varNames', nmr);
    CondInd(i) = cond(grp{i}); % less 1 is good
    
    figure('Name', ['Collinearuty Diagnostics of Cluster ' int2str(i)], 'position', [0, 0, 900, 350])
    [sValue, condIdx, VarDecomp] = collintest(grpOne{i},'tolIdx',10,'tolProp',0.55,'display','off','plot','on','varNames', ['const', nmr]);
    MatDecomp{i} = [sValue, condIdx, VarDecomp];
    leg = legend('Location', 'northeast');
    set(leg, 'Box', 'off');
    for j = 1:length(condIdx)-2 
        leg.String{j} = ['\mu=' int2str(condIdx(j+2))] ;
    end 
    leg.String{length(condIdx)-1} = 'Level';
    saveas(gcf, [IntData.hpp '_Belsley_Cluster=' int2str(i) '.png'])
        
    VIF(i,:) = diag(inv(R{i}))'; % Estimator Variance of clusters. If it is less than 5-10 then "Well done"
%    grpLog = log10(grp{i});
%    grpLog(grpLog == -Inf) = 0;
    scatterPlotMatrixTiled(grp{i}, nmr, i, IntData, [], true, R{i}, PValue{i});
%{    
    if IntData.rmv(i)~=0
        grp{i}(:,IntData.rmv(i)) = [];  
    end

    bReg{i,1} = fitlm(grp{i}, criteria{i}(:,1));
    bReg{i,2} = fitlm(grp{i}, criteria{i}(:,2)); 
    bReg{i,3} = fitlm(grp{i}, criteria{i}(:,3)); 
%}
end
%}