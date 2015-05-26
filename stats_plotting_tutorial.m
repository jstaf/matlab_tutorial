%% Stats and plotting tutorial
% Jeff Stafford

% The following code for plots is from the MATLAB plots
% gallery at: http://www.mathworks.com/discovery/gallery.html

%% standard line plot

% Define values for x, y1, and y2
x  = 0:0.1:2*pi;
y1 = cos(x);
y2 = sin(x);

% Plot y1 vs. x (blue, solid) and y2 vs. x (red, dashed)
figure;
% format plot(x vals, y vals, color+marker, ...additional lines + options)
plot(x, y1, 'b', x, y2, 'r-.', 'LineWidth', 2);
% Set the axis limits
axis([0 2*pi -1.5 1.5]);

%% bar plots

% Create data for childhood disease cases
measles = [38556 24472 14556 18060 19549 8122 28541 7880 3283 4135 7953 1884];
mumps = [20178 23536 34561 37395 36072 32237 18597 9408 6005 6268 8963 13882];
chickenPox = [37140 32169 37533 39103 33244 23269 16737 5411 3435 6052 12825 23332];

% Create a vertical bar chart using the bar function
figure;
% drawing a bar with data from the above datasets at locations 1:12
bar(1:12, [measles', mumps', chickenPox'], 1);

% Set the axis limits
% set axis bounds... format [xmin, xmax, ymin, ymax]
axis([0 13 0 40000]);
% manually set the x axis tick marks... gca grabs the current axis from the
% current figure
set(gca, 'XTick', 1:12);

% Add title and axis labels
title('Childhood diseases by month');
xlabel('Month');
ylabel('Cases (in thousands)');

% Add a legend
legend('Measles', 'Mumps', 'Chicken pox');

%% scatter plots

% create equally spaced x values
x = linspace(0,3*pi,200);
% create semi-random y values following a cosine curve
y = cos(x) + rand(1,200);
% the size for our points will increase steadily to an area of 50
a = linspace(1, 50, 200);
% the colors for our points
c = linspace(1,10,length(x));
% creat the scatterplot
scatter(x,y,a,c,'filled')

%% adding plots together

y2 = cos(x) + 0.5;
figure('Name', 'double plotting');
% tell matlab to wait and graph everything in the same plot from now on
hold on;
% plot the cosine function
plot(x, y2, 'red', 'linew', 2);
% plot the semi random points from the last example
scatter(x, y, a, c,'filled');
% tell matlab to stop graphing everything in the same plot
hold off;
xlabel('x values');
ylabel('y values');
title('random title');

%% ######################################################
% Make a scatterplot of the following values... with red markers and a size
% of 20

XVals = 1:20;
YVals = rand(1, length(XVals));

% Make a line plot of the same data, but with a line width of 3. Make the
% line purple just for kicks.


% plot the two on the same plot and change the axis to have x limits of 0
% and 12, and y limits of 0.5 and 1

%% ttests and 1-way ANOVA

% we are going to load a built-in dataset...
load fisheriris.mat;

% This is a set of flower lengths and widths taken in 1936. It gets used a
% lot for stats examples.

% turn the species names into a categorical variable
species = categorical(species);

% These are the labels for each of the columns, not sure why these aren't in there
Labels = {'sepal_length', 'sepal_width', 'petal_length', 'petal_width'};

% MATLAB is weird and doesn't have any truly easy ways to attach labels and
% stuff to data. We are going to have to handle the data/labels separately.

% Lets create a few example plots:

% the infamous boxplot... lets compare sepal to petal lengths
boxplot(meas(:, [1,3]), 'Label', Labels([1, 3]));
ylabel('Length (mm)');
title('This is some data on iris flowers');

% lets do a two sample t-test
[decision, pval, conf_int, stats] = ttest2(meas(:, 1), meas(:, 3));
stats

% what if we wanted to look at petal length by species?
boxplot(meas(:, 3), species); 
ylabel('Length (mm)');
xlabel('Species');

% let's do a one way ANOVA
[pval, tbl, stats] = anova1(meas(:, 3), species);
% and a post-hoc Tukey HSD
[results, means, handle, groupNames] = multcompare(stats);
% as you can see, everything is REALLY significant

% grab the actual p values for the multiple comparison, ugly, I know...
[groupNames(results(:,1)), groupNames(results(:,2)), num2cell(results(:,3:6))]

% This is a copied from the MATLAB documentation:

% The first two columns show the pair of groups that are compared. The
% fourth column shows the difference between the estimated group means. The
% third and fifth columns show the lower and upper limits for the 95%
% confidence intervals of the true difference of means. The sixth column
% shows the p-value for a hypothesis that the true difference of means for
% the corresponding groups is equal to zero.

%% ###################################################3
% Do a ttest on the the following data. What's the p-value?
data1 = 1:20;
data2 = 15:0.5:40;