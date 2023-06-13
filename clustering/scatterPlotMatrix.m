function scatterPlotMatrix(X, var_labels, var_types, need_save)
% Scatter Plot Matrix
% histogram in diagonal line, correlation coefficients in upper triangular, and scatter plots in the lower triangular
% The font size and color will changed together with the value of corelation coefficients
% Input
%      X          : data matrix, each row represent a sample while each column represent a variable
%      var_labels : cell type variable. Names for each variable. Numbers with prefix 'V' will be used if it's empty
%      var_types  : cell type variable. There are two types for each variable: 'continuous' or 'discrete'. Spearman correlation coefficients will be used for discrete variables while Pearson for continuous variables. The program will determin the type of each variable if it's empty.
%      need_save  : whether to save created figure.


[~, p] = size(X);  % p represent the number of variables

if nargin < 4
    need_save = false;
end

if nargin < 3 || isempty(var_types)
    var_types = cell(p, 1);
    for i = 1:p
        if length(unique(X(:, i))) > 5
            var_types{i} = 'continuous';
        else
            var_types{i} = 'discrete';
        end
    end
end

if nargin < 2 || isempty(var_labels)
    var_labels = cell(p, 1);
    for i = 1:p
        var_labels{i} = sprintf('V%d', i);
    end
end

if length(var_labels) ~= p
    error('dimension of labels does not agree with data matrix!')
end
if length(var_types) ~= p
    error('dimension of types does not agree with data matrix!')
end

% The figure size of Matlab default is 560 pixels * 420 pixels
figure('position', [50, 0, 800, 800])
% Initialize the figure object with gobjects function
H = gobjects(p, p);
for i = 1:p
    for j = 1:i
        H(i, j) = subplot(p, p, (i-1)*p+j);
%        H(i, j) = tight_subplot();
        if i == j
            if strcmp(var_types{i}, 'discrete')
                hist(X(:, i))
                h = findobj(gca, 'Type', 'patch');
                set(h, 'FaceColor', [0, 0.45, 0.74], 'EdgeColor', [0, 0, 0])
            else
                % The diagonal line is histogram with Nonparametric kernel-smoothing distribution
                h = histfit(X(:, i), [], 'kernel');
                % Reset the width of line as the default value seems too wider
                set(h(2), 'LineWidth', 1.5)
            end
            % Add the variable labels into figure in a manner of text
            text(0.5, 0.9, var_labels(j), 'Units', 'normalized',...
                'HorizontalAlignment', 'center', 'Color', 'black', 'FontSize', 12)
        else
            % Scatter plots in the lower triangular
            scatter(X(:, j), X(:, i), 75, [0 0.45 0.74], '.')
            % Add a loess line, i.e locally estimated scatterplot smoothing
            loess = smooth(X(:, j), X(:, i), 0.9, 'loess');
            % Do not forget sort data first, or it will not be a smoothed line!
            [plot_x, index] = sort(X(:, j));
            hold on
            plot(plot_x, loess(index), 'k-', 'LineWidth', 1.5)
            hold off
        end
        % Only the figures in the first column show y axis
        if j ~= 1
            set(gca, 'ytick', [])
        end
        % Only the figures in the last row show x axis
        if i ~= p
            set(gca, 'xtick', [])
        end
    end
end
% Align the x axis of all figures in one column
% The x axis of figures derived from histfit function will not be the same as scatter plot
for i = 1:p
    linkaxes(H(:, i), 'x');
    x_tick = get(H(p, i), 'Xtick');
    adj = round(mean(diff(x_tick))) / 10;
    set(H(p, i), 'xlim', [min(X(:, i))-adj, max(X(:, i))+adj]);
end

% Circles of correlation coefficients in upper triangular
% colormap from 'bwr' of Python matplotlib, which contains 256 colors
cmap = [ 0         0    1.0000
    0.0078    0.0078    1.0000
    0.0157    0.0157    1.0000
    0.0235    0.0235    1.0000
    0.0314    0.0314    1.0000
    0.0392    0.0392    1.0000
    0.0471    0.0471    1.0000
    0.0549    0.0549    1.0000
    0.0627    0.0627    1.0000
    0.0706    0.0706    1.0000
    0.0784    0.0784    1.0000
    0.0863    0.0863    1.0000
    0.0941    0.0941    1.0000
    0.1020    0.1020    1.0000
    0.1098    0.1098    1.0000
    0.1176    0.1176    1.0000
    0.1255    0.1255    1.0000
    0.1333    0.1333    1.0000
    0.1412    0.1412    1.0000
    0.1490    0.1490    1.0000
    0.1569    0.1569    1.0000
    0.1647    0.1647    1.0000
    0.1725    0.1725    1.0000
    0.1804    0.1804    1.0000
    0.1882    0.1882    1.0000
    0.1961    0.1961    1.0000
    0.2039    0.2039    1.0000
    0.2118    0.2118    1.0000
    0.2196    0.2196    1.0000
    0.2275    0.2275    1.0000
    0.2353    0.2353    1.0000
    0.2431    0.2431    1.0000
    0.2510    0.2510    1.0000
    0.2588    0.2588    1.0000
    0.2667    0.2667    1.0000
    0.2745    0.2745    1.0000
    0.2824    0.2824    1.0000
    0.2902    0.2902    1.0000
    0.2980    0.2980    1.0000
    0.3059    0.3059    1.0000
    0.3137    0.3137    1.0000
    0.3216    0.3216    1.0000
    0.3294    0.3294    1.0000
    0.3373    0.3373    1.0000
    0.3451    0.3451    1.0000
    0.3529    0.3529    1.0000
    0.3608    0.3608    1.0000
    0.3686    0.3686    1.0000
    0.3765    0.3765    1.0000
    0.3843    0.3843    1.0000
    0.3922    0.3922    1.0000
    0.4000    0.4000    1.0000
    0.4078    0.4078    1.0000
    0.4157    0.4157    1.0000
    0.4235    0.4235    1.0000
    0.4314    0.4314    1.0000
    0.4392    0.4392    1.0000
    0.4471    0.4471    1.0000
    0.4549    0.4549    1.0000
    0.4627    0.4627    1.0000
    0.4706    0.4706    1.0000
    0.4784    0.4784    1.0000
    0.4863    0.4863    1.0000
    0.4941    0.4941    1.0000
    0.5020    0.5020    1.0000
    0.5098    0.5098    1.0000
    0.5176    0.5176    1.0000
    0.5255    0.5255    1.0000
    0.5333    0.5333    1.0000
    0.5412    0.5412    1.0000
    0.5490    0.5490    1.0000
    0.5569    0.5569    1.0000
    0.5647    0.5647    1.0000
    0.5725    0.5725    1.0000
    0.5804    0.5804    1.0000
    0.5882    0.5882    1.0000
    0.5961    0.5961    1.0000
    0.6039    0.6039    1.0000
    0.6118    0.6118    1.0000
    0.6196    0.6196    1.0000
    0.6275    0.6275    1.0000
    0.6353    0.6353    1.0000
    0.6431    0.6431    1.0000
    0.6510    0.6510    1.0000
    0.6588    0.6588    1.0000
    0.6667    0.6667    1.0000
    0.6745    0.6745    1.0000
    0.6824    0.6824    1.0000
    0.6902    0.6902    1.0000
    0.6980    0.6980    1.0000
    0.7059    0.7059    1.0000
    0.7137    0.7137    1.0000
    0.7216    0.7216    1.0000
    0.7294    0.7294    1.0000
    0.7373    0.7373    1.0000
    0.7451    0.7451    1.0000
    0.7529    0.7529    1.0000
    0.7608    0.7608    1.0000
    0.7686    0.7686    1.0000
    0.7765    0.7765    1.0000
    0.7843    0.7843    1.0000
    0.7922    0.7922    1.0000
    0.8000    0.8000    1.0000
    0.8078    0.8078    1.0000
    0.8157    0.8157    1.0000
    0.8235    0.8235    1.0000
    0.8314    0.8314    1.0000
    0.8392    0.8392    1.0000
    0.8471    0.8471    1.0000
    0.8549    0.8549    1.0000
    0.8627    0.8627    1.0000
    0.8706    0.8706    1.0000
    0.8784    0.8784    1.0000
    0.8863    0.8863    1.0000
    0.8941    0.8941    1.0000
    0.9020    0.9020    1.0000
    0.9098    0.9098    1.0000
    0.9176    0.9176    1.0000
    0.9255    0.9255    1.0000
    0.9333    0.9333    1.0000
    0.9412    0.9412    1.0000
    0.9490    0.9490    1.0000
    0.9569    0.9569    1.0000
    0.9647    0.9647    1.0000
    0.9725    0.9725    1.0000
    0.9804    0.9804    1.0000
    0.9882    0.9882    1.0000
    0.9961    0.9961    1.0000
    1.0000    0.9961    0.9961
    1.0000    0.9882    0.9882
    1.0000    0.9804    0.9804
    1.0000    0.9725    0.9725
    1.0000    0.9647    0.9647
    1.0000    0.9569    0.9569
    1.0000    0.9490    0.9490
    1.0000    0.9412    0.9412
    1.0000    0.9333    0.9333
    1.0000    0.9255    0.9255
    1.0000    0.9176    0.9176
    1.0000    0.9098    0.9098
    1.0000    0.9020    0.9020
    1.0000    0.8941    0.8941
    1.0000    0.8863    0.8863
    1.0000    0.8784    0.8784
    1.0000    0.8706    0.8706
    1.0000    0.8627    0.8627
    1.0000    0.8549    0.8549
    1.0000    0.8471    0.8471
    1.0000    0.8392    0.8392
    1.0000    0.8314    0.8314
    1.0000    0.8235    0.8235
    1.0000    0.8157    0.8157
    1.0000    0.8078    0.8078
    1.0000    0.8000    0.8000
    1.0000    0.7922    0.7922
    1.0000    0.7843    0.7843
    1.0000    0.7765    0.7765
    1.0000    0.7686    0.7686
    1.0000    0.7608    0.7608
    1.0000    0.7529    0.7529
    1.0000    0.7451    0.7451
    1.0000    0.7373    0.7373
    1.0000    0.7294    0.7294
    1.0000    0.7216    0.7216
    1.0000    0.7137    0.7137
    1.0000    0.7059    0.7059
    1.0000    0.6980    0.6980
    1.0000    0.6902    0.6902
    1.0000    0.6824    0.6824
    1.0000    0.6745    0.6745
    1.0000    0.6667    0.6667
    1.0000    0.6588    0.6588
    1.0000    0.6510    0.6510
    1.0000    0.6431    0.6431
    1.0000    0.6353    0.6353
    1.0000    0.6275    0.6275
    1.0000    0.6196    0.6196
    1.0000    0.6118    0.6118
    1.0000    0.6039    0.6039
    1.0000    0.5961    0.5961
    1.0000    0.5882    0.5882
    1.0000    0.5804    0.5804
    1.0000    0.5725    0.5725
    1.0000    0.5647    0.5647
    1.0000    0.5569    0.5569
    1.0000    0.5490    0.5490
    1.0000    0.5412    0.5412
    1.0000    0.5333    0.5333
    1.0000    0.5255    0.5255
    1.0000    0.5176    0.5176
    1.0000    0.5098    0.5098
    1.0000    0.5020    0.5020
    1.0000    0.4941    0.4941
    1.0000    0.4863    0.4863
    1.0000    0.4784    0.4784
    1.0000    0.4706    0.4706
    1.0000    0.4627    0.4627
    1.0000    0.4549    0.4549
    1.0000    0.4471    0.4471
    1.0000    0.4392    0.4392
    1.0000    0.4314    0.4314
    1.0000    0.4235    0.4235
    1.0000    0.4157    0.4157
    1.0000    0.4078    0.4078
    1.0000    0.4000    0.4000
    1.0000    0.3922    0.3922
    1.0000    0.3843    0.3843
    1.0000    0.3765    0.3765
    1.0000    0.3686    0.3686
    1.0000    0.3608    0.3608
    1.0000    0.3529    0.3529
    1.0000    0.3451    0.3451
    1.0000    0.3373    0.3373
    1.0000    0.3294    0.3294
    1.0000    0.3216    0.3216
    1.0000    0.3137    0.3137
    1.0000    0.3059    0.3059
    1.0000    0.2980    0.2980
    1.0000    0.2902    0.2902
    1.0000    0.2824    0.2824
    1.0000    0.2745    0.2745
    1.0000    0.2667    0.2667
    1.0000    0.2588    0.2588
    1.0000    0.2510    0.2510
    1.0000    0.2431    0.2431
    1.0000    0.2353    0.2353
    1.0000    0.2275    0.2275
    1.0000    0.2196    0.2196
    1.0000    0.2118    0.2118
    1.0000    0.2039    0.2039
    1.0000    0.1961    0.1961
    1.0000    0.1882    0.1882
    1.0000    0.1804    0.1804
    1.0000    0.1725    0.1725
    1.0000    0.1647    0.1647
    1.0000    0.1569    0.1569
    1.0000    0.1490    0.1490
    1.0000    0.1412    0.1412
    1.0000    0.1333    0.1333
    1.0000    0.1255    0.1255
    1.0000    0.1176    0.1176
    1.0000    0.1098    0.1098
    1.0000    0.1020    0.1020
    1.0000    0.0941    0.0941
    1.0000    0.0863    0.0863
    1.0000    0.0784    0.0784
    1.0000    0.0706    0.0706
    1.0000    0.0627    0.0627
    1.0000    0.0549    0.0549
    1.0000    0.0471    0.0471
    1.0000    0.0392    0.0392
    1.0000    0.0314    0.0314
    1.0000    0.0235    0.0235
    1.0000    0.0157    0.0157
    1.0000    0.0078    0.0078
    1.0000         0         0];
index = linspace(-1, 1, size(cmap, 1));
for i = 1:p
    for j = (i+1):p
        subplot(p, p, (i-1)*p+j)
        % correlation coefficients in upper triangular
        if strcmp(var_types(i), 'discrete') || strcmp(var_types(j), 'discrete')
            [r, p_value] = corr(X(:, i), X(:, j), 'type', 'Pearson', 'rows', 'complete');
        else
            [r, p_value] = corr(X(:, i), X(:, j), 'type', 'Spearman', 'rows', 'complete');
        end
        text(0.5, 0.5, sprintf('R=%.2f\nP=%.2f', r, p_value), 'Units', 'normalized',...
            'HorizontalAlignment', 'center')
        % The smaller p value is, the larger the circle is
        xlim manual
        ylim manual
        xlim([-3, 3]);
        ylim([-3, 3]);
        tmp_xlim = xlim;
        tmp_ylim = ylim;
        center = [(tmp_xlim(1)+tmp_xlim(2))/2, (tmp_ylim(1)+tmp_ylim(2))/2];
        radius = max(1-p_value, 0.0001) * (tmp_xlim(2) - center(1));
        pos = [center-radius 2*radius 2*radius];
        % Positive correlation shown by red, while negative by blue
        for k = 1:length(index)
            if r < index(k)
                ind = k - 1;
                break
            end
        end
        if r == 1
            ind = length(index);
        end
        rectangle('Position',pos, 'Curvature',[1 1], 'FaceColor', cmap(ind, :), 'EdgeColor', cmap(ind, :))
        axis equal
        set(gca, 'xtick', [])
        set(gca, 'ytick', []) 
    end
end

if need_save
    saveas(gcf, 'plot.jpg')
end
end