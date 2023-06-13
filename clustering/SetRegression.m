%% Initial data
close all
data = table2array(data_cluster);
X = data(:, 1:13);
Y = data(:, 14:16);
clr = {[0 0.45 0.74], [0.85 0.33 0.1], [0.93 0.69 0.13], ...
       [0.49 0.18 0.56], [0.47 0.67 0.19]}; % blue, red, yellow, puple and green
nmpr = {'D_g', 'D_y', 'l_1' , 'b_{s2}', '\delta', 'R_p', 'd_d', 'r_{ld}', ...
        'w_{pmn}', 'w_{pmj}', 'h_{ps}', 'b_{p}', 'b_{so}'};   
[nC, nP] = size(X);
[~, nR] = size(Y);

%% Regression Learner Data. Liner model. Ex.: zscore(X)
figure('Name', 'Main Effects of Linear Model Predictors', 'position', [0, 200, 540, 540])
lm = cell(1, nR); 
ypred = cell(3, nR); 
for i = 1:nR
    y = Y(:, i);
    lm{i} = fitlm(X, y); 
    h = plotEffects(lm{i});
    for j = 1:nP
        h(j, 1).Color = clr{i};
        h(j, 1).LineWidth = 1;
    end
    hold on
    ypred{1, i} = predict(lm{i}, X);
end
ax = gca; ax.FontSize = 12; ax.XLim = [-3 3]; ax.YLim = [1 nP];
box off; grid on; hold off
saveas(gcf, 'MainEffect_Linear_Model.png')

%%  Multi-variable polynomial regression
mpr = cell(1, nR); 
yhatNew = zeros(nC, nR);
for i = 1:nR
    y = Y(:, i);
    mpr{i} = MultiPolyRegress(X, y, 2);
    for j = 1:nC
        x = X(j,:);
        NewScores = repmat(x,[length(mpr{i}.PowerMatrix) 1]).^mpr{i}.PowerMatrix;
        EvalScores = ones(length(mpr{i}.PowerMatrix),1);
        for ii = 1:size(mpr{i}.PowerMatrix,2)
            EvalScores = EvalScores.*NewScores(:,ii);
        end
        yhatNew(j, i) = mpr{i}.Coefficients'*EvalScores;      
    end
    ypred{2, i} = yhatNew(:, i);
end

%% Feature selection using neighborhood component analysis for regression 
figure('Name', 'Neighborhood Component Analysis for Regression', 'position', [360,200,560,420])
values = [];
for i = 1:nR
    y = Y(:, i);
    ncm = fsrnca(X, y);
    value = ncm.FeatureWeights';
    values = [values; value/max(value)];
end
bar(1:nP, values, 1);
set(gca, 'xtick', 1:nP, 'xticklabel', nmpr, 'ytick', 0:.1:1, 'FontSize', 12)
xlabel('Predictor variable')
ylabel('Feature Weight')
box off
ax = gca; ax.YGrid = 'on';



%% Rank importance of predictors using ReliefF or RReliefF algorithm
%{
figure ('Name', 'Rank importance of predictors using ReliefF or RReliefF algorithm', 'position', [650,200,560,420])
value = [];
for i = 1:nR
    y = Y(:, i);
    [idx, weights] = relieff(X, y, 20, 'method', 'regression', 'categoricalx', 'on');
    value = [value; weights/max(weights)];
end    
bar(1:nP, value, 1)
set(gca, 'xtick', 1:nP, 'xticklabel', nmpr, 'ytick', 0:.1:1, 'FontSize', 12)
xlabel('Predictor variable')
ylabel('Predictor importance weight')
box off
ax = gca; ax.YGrid = 'on';
%}

%% Fit binary decision tree for regression
figure ('Name', 'Tree for regression', 'position', [950,200,560,420])
value = [];
mse = cell(1, nR); 
for i = 1:nR
    rng(1);
    y = Y(:, i);
    tree = fitrtree(zscore(X), y, 'CrossVal', 'on');
    mse{i} = kfoldLoss(tree);
    imp = predictorImportance(tree.Trained{:});
    imp = mean(imp, 1);
    value = [value; imp./max(imp)];
end
bar(1:nP, value, 1)
set(gca, 'xtick', 1:nP, 'xticklabel', nmpr, 'ytick', 0:.1:1, 'FontSize', 12)
xlabel('Predictor variable')
ylabel('Predictor importance')
box off; 
ax = gca; ax.YGrid = 'on';
saveas(gcf, 'PredictorImportance_TreeRegression.png')
%view(tree.Trained{1}, 'Mode', 'graph')

%% Random forest 
impOOB = [];
forest = cell(1, nR);
frmse = zeros(1, nR);
%X = [X(:,1),X(:,2),X(:,4)];
for i = 1:nR
    t = templateTree('NumVariablesToSample','all');
    rng(1); % For reproducibility
    y = Y(:, i);
    forest{i} = fitrensemble(X, y,'Method','Bag','NumLearningCycles',100, 'Learners',t);
    yHat = oobPredict(forest{i});
    R2 = corr(forest{i}.Y,yHat)^2
    frmse(i) = sqrt(loss(forest{i}, X, y))    
    values = oobPermutedPredictorImportance(forest{i});
    impOOB = [impOOB; values/max(values)];
end
figure('Name', 'Unbiased Predictor Importance Estimates', 'position', [1050,200,560,420])
bar(1:nP, impOOB, 1)
set(gca, 'xtick', 1:nP, 'xticklabel', nmpr, 'ytick', 0:.1:1, 'FontSize', 12)
xlabel('Predictor variable')
ylabel('Predictor importance')
box off; 
ax = gca; ax.YGrid = 'on';
saveas(gcf, 'PredictorImportance_ForestRegression.png')

%% Plot true and calculated values
numP = 3;
plot([1.2e-4 2e-4], [1.2e-4 2e-4], 'LineWidth', 2, 'Color', [0 0 0]); hold on
plot(Y(:, numP),ypred{1, numP}, 'Color', clr{1}, 'Marker', '.', 'LineStyle', 'none'); 
plot(Y(:, numP),ypred{2, numP}, 'Color', clr{2}, 'Marker', '.', 'LineStyle', 'none');
ax = gca; box off; grid on;  
ax.XLim = [1.2e-4 2e-4]; ax.YLim = [1.2e-4 2e-4];

%% Fit a Gaussian process regression 
figure ('Name', 'Fit a Gaussian process regression')
rng(1);
y = Y(:, i);
gprMdl = fitrgp(X, y);
plotPartialDependence(gprMdl, 4, 'Conditional', 'centered')

