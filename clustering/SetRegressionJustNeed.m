%% Initial data
close all
data = table2array(data_cluster);
X = data(:, 1:13);
Y = data(:, 14:16);
clr = {[0 0.45 0.74], [0.85 0.33 0.1], [0.93 0.69 0.13], ...
       [0.49 0.18 0.56], [0.47 0.67 0.19]}; % blue, red, yellow, puple and green
nmpr = {'D_g', 'D_y', 'l_1' , 'b_{s2}', '\delta', 'R_p', 'd_d', 'r_{ld}', ...
        'w_{pmn}', 'w_{pmj}', 'h_{ps}', 'b_{p}', 'b_{so}'};   
%X = X(:,1:5);
nMdl = 4;
[nC, nP] = size(X);
[~, nR] = size(Y);
ypred = cell(nMdl, nR);
cR = zeros(nR, 2*nMdl);

%% Linear regression. Ex.: zscore(X)
k = 1;
f1 = figure('Name', 'Main Effects of Linear Model Predictors', 'position', [0, 200, 540, 540]);
f2 = figure('Name', 'Histogram of Linear Model Residuals', 'position', [100, 200, 620, 500]);
lm = cell(1,nR); 
for i = 1:nR
    y = Y(:,i);
    lm{i} = fitlm(X, y); 
    cR(i,k) = lm{i}.RMSE; cR(i,k+1) = lm{i}.Rsquared.Adjusted; 
    figure(f1);
    h1 = plotEffects(lm{i});
    hold on
    for j = 1:nP
        h1(j,1).Color = clr{i};
        h1(j,1).LineWidth = 1;
    end
    ypred{k,i} = predict(lm{i},X);
    figure(f2);
    h2 = plotResiduals(lm{i}, 'histogram', 'ResidualType', 'standardized');
    alpha = [1; 0.7; 0.3];
    set(h2, 'FaceColor', clr{i}, 'FaceAlpha', alpha(i))
    hold on
end
figure(f1);
ax = gca; ax.FontSize = 12; ax.XLim = [-3 3]; ax.YLim = [1 nP];
box off; grid on; hold off
saveas(gcf, 'MainEffect_Linear_Model.png')
figure(f2);
ax = gca; ax.FontSize = 12; ax.XLim = [-3 3];
box off; grid on; hold off
saveas(gcf, 'Histogram_of_residuals.png')

%%  Multi-variable polynomial regression
k = k + 1;
mpr = cell(1, nR); 
yhatNew = zeros(nC, nR);
for i = 1:nR
    y = Y(:, i);
    mpr{i} = MultiPolyRegress(X, y, 2);
    cR(i, 2*k-1) = mpr{i}.RMSE; cR(i, 2*k) = mpr{i}.RSquare; 
    for j = 1:nC
        x = X(j,:);
        NewScores = repmat(x,[length(mpr{i}.PowerMatrix) 1]).^mpr{i}.PowerMatrix;
        EvalScores = ones(length(mpr{i}.PowerMatrix),1);
        for ii = 1:size(mpr{i}.PowerMatrix,2)
            EvalScores = EvalScores.*NewScores(:,ii);
        end
        yhatNew(j, i) = mpr{i}.Coefficients'*EvalScores;      
    end
    ypred{k, i} = yhatNew(:, i);
end

%% Random Forest Regression
k = k + 1;
impOOB = [];
forest = cell(1, nR);
for i = 1:nR
    t = templateTree('NumVariablesToSample','all');
    rng(1); % For reproducibility
    y = Y(:, i);
    forest{i} = fitrensemble(X, y,'Method','Bag','NumLearningCycles',100, 'Learners',t);
%   forest{i} = fitrensemble(X, y,'Learners',t, 'OptimizeHyperparameters',{'NumLearningCycles','LearnRate','MaxNumSplits'});
    yHat = oobPredict(forest{i});
    cR(i, 2*k-1) = sqrt(loss(forest{i}, X, y)); cR(i, 2*k) = corr(forest{i}.Y,yHat)^2; 
    values = oobPermutedPredictorImportance(forest{i});
    impOOB = [impOOB; values/max(values)];
    ypred{k, i} = predict(forest{i}, X);
end
figure('Name', 'Unbiased Predictor Importance Estimates', 'position', [360,200,560,420])
bar(1:nP, impOOB, 1)
set(gca, 'xtick', 1:nP, 'xticklabel', nmpr, 'ytick', 0:.1:1, 'FontSize', 12)
xlabel('Predictor variable')
ylabel('Predictor importance')
box off; 
ax = gca; ax.YGrid = 'on';
saveas(gcf, 'PredictorImportance_ForestRegression.png')

%% CreatePredictiveEnsemleCV
k = k + 1;
ypred{k, 3} = predict(RandomForestBaksanCurrent, X);

%% Plot true and calculated values
numP = 3;
maxY = max(Y(:, numP));
minY = min(Y(:, numP));
figure('Name', 'Plot true and calculated value', 'position', [775,200,560,530])
plot([0 1], [0 1], 'LineWidth', 2, 'Color', [0 0 0]); hold on
plot((Y(:, numP)-minY)/(maxY-minY), (ypred{1, numP}-minY)/(maxY-minY), 'Color', clr{1}, 'Marker', '.', 'LineStyle', 'none', 'MarkerSize', 15);
plot((Y(:, numP)-minY)/(maxY-minY), (ypred{2, numP}-minY)/(maxY-minY), 'Color', clr{2}, 'Marker', '.', 'LineStyle', 'none', 'MarkerSize', 15);
%plot((Y(:, numP)-minY)/(maxY-minY), (ypred{3, numP}-minY)/(maxY-minY), 'Color', clr{3}, 'Marker', '.', 'LineStyle', 'none', 'MarkerSize', 15);
plot((Y(:, numP)-minY)/(maxY-minY), (ypred{4, numP}-minY)/(maxY-minY), 'Color', clr{3}, 'Marker', '.', 'LineStyle', 'none', 'MarkerSize', 15);
ax = gca; box off; grid on; ax.FontSize = 14;
xticks(0:0.2:1); yticks(0:0.2:1);
ax.XLim = [0 1]; ax.YLim = [0 1];
saveas(gcf, 'ComparationModels.png')

%% Plot 3d surface