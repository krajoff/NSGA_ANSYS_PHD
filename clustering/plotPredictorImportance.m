function plotPredictorImportance(mdl)
% Plot predictor importance of Tree model
%mdl = trainedModel;
figure
values = mdl.RegressionTree.predictorImportance;
values = values/max(values);
names = mdl.RegressionTree.PredictorNames;
[srtValues, idx] = sort(values, 'descend');
srtNames = names(idx);
bar(srtValues)
xticklabels(srtNames)
xtickangle(90)
%set(gca, 'Yscale', 'log')
ax = gca;
ax.YGrid = 'on';
box off
view(mdl.RegressionTree, 'Mode', 'graph')
end