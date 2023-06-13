%*************************************************************************
%   Test Problem : 'ANSYS Workbench'
%   Reference : [1] Deb K, Pratap A, Agarwal S, et al. A fast and elitist 
%   multiobjective genetic algorithm NSGA-II[J]. Evolutionary Computation. 
%   2002, 6(2): 182-197.
%*************************************************************************
options = nsgaopt();                    % create default options structure
options.popsize = 10000;               % populaion size 750
options.maxGen  = 10;                    % max generation 40

options.numObj = 3;                     % number of objectives
options.numVar = 13;                    % number of design variables
options.numCons = 0;                    % number of constraints

% lower bound
options.lb = [2483 100 727 10.8 10 936 10 5 465 0 56 332 4]; 
% upper bound
options.ub = [2700 311 775 25 16 1050 17 10 490 20 80 350 6]; 
options.vartype = [2 2 2 1 1 2 1 2 2 2 2 2 2];
options.objfun = @TP_Baksan_R_objfun;   % objective function handle
options.plotInterval = 1;         % interval between two calls of "plotnsga". 
options.useParallel = 'no'; 
options.poolsize = 3; 
result = nsga2(options);                % begin the optimization!