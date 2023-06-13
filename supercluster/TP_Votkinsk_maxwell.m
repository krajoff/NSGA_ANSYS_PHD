%*************************************************************************
%   Test Problem : 'Ansoft Maxwell'
%   Reference : [1] Deb K, Pratap A, Agarwal S, et al. A fast and elitist 
%   multiobjective genetic algorithm NSGA-II[J]. Evolutionary Computation. 
%   2002, 6(2): 182-197.
%*************************************************************************
options = nsgaopt();                    % create default options structure
options.popsize = 2;       %10000       % populaion size
options.maxGen  = 2;       %30          % max generation

options.numObj = 3;                     % number of objectives
options.numVar = 13;                    % number of design variables
options.numCons = 0;                    % number of constraints
% lower bound
options.lb = [14000 14800 1700 14 18 1100 18 3 330 0 40 265 3]; 
% upper bound
options.ub = [14500 15100 1800 23 26 1300 23 6 370 25 60 295 5]; 
options.vartype = [2 2 2 1 2 2 2 2 2 2 2 2 2];
options.objfun = @TP_Votkinsk_maxwell_objfun;    % objective function handle
options.plotInterval = 1;               % interval between two calls of "plotnsga". 
% oldresult=loadpopfile('pop-2.txt');
% options.initfun={@initpop, oldresult};
options.useParallel = 'yes'; 
options.poolsize = 2; 
result = nsga2(options);                % begin the optimization!