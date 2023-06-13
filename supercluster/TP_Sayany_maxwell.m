%*************************************************************************
%   Test Problem : 'Ansoft Maxwell'
%   Reference : [1] Deb K, Pratap A, Agarwal S, et al. A fast and elitist 
%   multiobjective genetic algorithm NSGA-II[J]. Evolutionary Computation. 
%   2002, 6(2): 182-197.
%*************************************************************************
options = nsgaopt();                    % create default options structure
options.popsize = 750;                  % populaion size
options.maxGen  = 40;                   % max generation

options.numObj = 3;                     % number of objectives
options.numVar = 13;                    % number of design variables
options.numCons = 0;                    % number of constraints
% lower bound
options.lb = [11000 12550 2700 21 25 2000 28 4 600 0 60 450 4]; 
% upper bound
options.ub = [12100 13500 2800 37 35 2160 32 10 650 35 90 530 6]; 
options.vartype = [2 2 2 1 1 2 2 2 2 2 2 2 2];
options.objfun = @TP_Sayany_maxwell_objfun;     % objective function handle
options.plotInterval = 100;                       % interval between two calls of "plotnsga". 
%oldresult=loadpopfile('populations.txt');
%options.initfun={@initpop, oldresult};
options.useParallel = 'yes'; 
options.poolsize = 4; 
result = nsga2(options);                % begin the optimization!