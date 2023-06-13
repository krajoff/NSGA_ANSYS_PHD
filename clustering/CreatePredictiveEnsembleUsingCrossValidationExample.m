%% Optimize Regression Ensemble Using Cross-Validation
% One way to create an ensemble of boosted regression trees that has satisfactory 
% predictive performance is to tune the decision tree complexity level using cross-validation. 
% While searching for an optimal complexity level, tune the learning rate to minimize 
% the number of learning cycles as well.
% 
% This example manually finds optimal parameters by using the cross-validation 
% option (the |'KFold'| name-value pair argument) and the |kfoldLoss| function. 
% Alternatively, you can use the |'OptimizeHyperparameters'| name-value pair argument 
% to optimize hyperparameters automatically. See <docid:stats_ug#bvds9wb Optimize 
% Regression Ensemble>.
% 
% Load the |carsmall| data set. Choose the number of cylinders, volume displaced 
% by the cylinders, horsepower, and weight as predictors of fuel economy.
close all
X = table2array(data_cluster(:,1:13));
Y = table2array(data_cluster(:,16));
%Tbl = data_cluster(:,1:5);
%Tbl=[Tbl data_cluster(:,16)];
%pName = 'Current'
%% 
% The default values of the tree depth controllers for boosting regression trees 
% are:
%% 
% * |10| for |MaxNumSplits|.
% * |5| for |MinLeafSize|
% * |10| for |MinParentSize|
%% 
% To search for the optimal tree-complexity level:
%% 
% # Cross-validate a set of ensembles. Exponentially increase the tree-complexity 
% level for subsequent ensembles from decision stump (one split) to at most _n_ 
% - 1 splits. _n_ is the sample size. Also, vary the learning rate for each ensemble 
% between 0.1 to 1.
% # Estimate the cross-validated mean-squared error (MSE) for each ensemble.
% # For tree-complexity level $j$, $j=1...J$, compare the cumulative, cross-validated 
% MSE of the ensembles by plotting them against number of learning cycles. Plot 
% separate curves for each learning rate on the same figure.
% # Choose the curve that achieves the minimal MSE, and note the corresponding 
% learning cycle and learning rate.
%% 
% Cross-validate a deep regression tree and a stump. Because the data contain 
% missing values, use surrogate splits. These regression trees serve as benchmarks.


rng(1) % For reproducibility
MdlDeep = fitrtree(X, Y, 'CrossVal','on','MergeLeaves','off', ...
    'MinParentSize',1,'Surrogate','on');
MdlStump = fitrtree(X, Y, 'MaxNumSplits',1,'CrossVal','on', ...
    'Surrogate','on');
%% 
% Cross-validate an ensemble of 150 boosted regression trees using 5-fold cross-validation. 
% Using a tree template:
%% 
% * Vary the maximum number of splits using the values in the sequence $\{2^0, 
% 2^1,...,2^m\}$. _m_ is such that $2^m$ is no greater than _n_ - 1. 
% * Turn on surrogate splits.
%% 
% For each variant, adjust the learning rate using each value in the set {0.1, 
% 0.25, 0.5, 1}.

n = size(X,1);
m = floor(log2(n - 1));
learnRate = [0.1 0.25 0.5 1];
numLR = numel(learnRate);
maxNumSplits = 2.^(0:m);
numMNS = numel(maxNumSplits);
numTrees = 150;
Mdl = cell(numMNS,numLR);

for k = 1:numLR
    for j = 1:numMNS
        t = templateTree('MaxNumSplits',maxNumSplits(j),'Surrogate','on');
        Mdl{j,k} = fitrensemble(X, Y, 'NumLearningCycles',numTrees, ...
            'Learners',t,'KFold',5,'LearnRate',learnRate(k));
    end
end
%% 
% Estimate the cumulative, cross-validated MSE of each ensemble.

kflAll = @(x)kfoldLoss(x,'Mode','cumulative');
errorCell = cellfun(kflAll,Mdl,'Uniform',false);
error = reshape(cell2mat(errorCell),[numTrees numel(maxNumSplits) numel(learnRate)]);
errorDeep = kfoldLoss(MdlDeep);
errorStump = kfoldLoss(MdlStump);
%% 
% Plot how the cross-validated MSE behaves as the number of trees in the ensemble 
% increases. Plot the curves with respect to learning rate on the same plot, and 
% plot separate plots for varying tree-complexity levels. Choose a subset of tree 
% complexity levels to plot.

mnsPlot = [1 round(numel(maxNumSplits)/2) numel(maxNumSplits)];
figure;
for k = 1:3
    subplot(2,2,k)
    plot(squeeze(error(:,mnsPlot(k),:)),'LineWidth',2)
    axis tight
    hold on
    h = gca;
    plot(h.XLim,[errorDeep errorDeep],'-.b','LineWidth',2)
    plot(h.XLim,[errorStump errorStump],'-.r','LineWidth',2)
    plot(h.XLim,min(min(error(:,mnsPlot(k),:))).*[1 1],'--k')
%    h.YLim = [10 50];    
    xlabel('Number of trees')
    ylabel('Cross-validated MSE')
    title(sprintf('MaxNumSplits = %0.3g', maxNumSplits(mnsPlot(k))))
    hold off
end
hL = legend([cellstr(num2str(learnRate','Learning Rate = %0.2f')); ...
        'Deep Tree';'Stump';'Min. MSE']);
hL.Position(1) = 0.6;
%% 
% Each curve contains a minimum cross-validated MSE occurring at the optimal 
% number of trees in the ensemble.
% 
% Identify the maximum number of splits, number of trees, and learning rate 
% that yields the lowest MSE overall.

[minErr,minErrIdxLin] = min(error(:));
[idxNumTrees,idxMNS,idxLR] = ind2sub(size(error),minErrIdxLin);
fprintf('\nMin. MSE = %0.5f',minErr)
fprintf('\nOptimal Parameter Values:\nNum. Trees = %d',idxNumTrees);
fprintf('\nMaxNumSplits = %d\nLearning Rate = %0.2f\n',...
    maxNumSplits(idxMNS),learnRate(idxLR))
%% 
% Create a predictive ensemble based on the optimal hyperparameters and the 
% entire training set.

tFinal = templateTree('MaxNumSplits',maxNumSplits(idxMNS),'Surrogate','on');
MdlFinal = fitrensemble(X, Y, 'NumLearningCycles',idxNumTrees, ...
    'Learners',tFinal,'LearnRate',learnRate(idxLR))
%% 
% |MdlFinal| is a |RegressionEnsemble|. To predict the fuel economy of a car 
% given its number of cylinders, volume displaced by the cylinders, horsepower, 
% and weight, you can pass the predictor data and |MdlFinal| to |predict|.
%% 
% Instead of searching optimal values manually by using the cross-validation 
% option (|'KFold'|) and the |kfoldLoss| function, you can use the |'OptimizeHyperparameters'| 
% name-value pair argument. When you specify |'OptimizeHyperparameters'|, the 
% software finds optimal parameters automatically using Bayesian optimization. 
% The optimal values obtained by using |'OptimizeHyperparameters'| can be different 
% from those obtained using manual search. 

t = templateTree('Surrogate','on');
mdl = fitrensemble(X, Y,'Learners',t, ...
    'OptimizeHyperparameters',{'NumLearningCycles','LearnRate','MaxNumSplits'})
yHat = predict(mdl, X);
R2 = corr(mdl.Y, yHat)^2
RMSE = sqrt(loss(mdl, X, mdl.Y))

yHat = predict(MdlFinal, X);
R2 = corr(MdlFinal.Y, yHat)^2
RMSE = sqrt(loss(MdlFinal, X, MdlFinal.Y))
%% 
% _Copyright 2012 The MathWorks, Inc._