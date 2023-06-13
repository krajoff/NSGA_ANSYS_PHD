%*************************************************************************
%   Test Problem : 'ANSYS Workbench'
%   Reference : [1] Deb K, Pratap A, Agarwal S, et al. A fast and elitist 
%   multiobjective genetic algorithm NSGA-II[J]. Evolutionary Computation. 
%   2002, 6(2): 182-197.
%*************************************************************************
options = nsgaopt();                    % create default options structure
options.popsize = 1000;                    % populaion size 750
options.maxGen  = 40;                    % max generation 40

options.numObj = 5;                     % number of objectives
options.numVar = 13;                    % number of design variables
options.numCons = 0;                    % number of constraints

% initial data
%{
DiaGap = 2500 DiaYoke = 3140 LengthCore = 750 Bs2 = 16.6 AirGap = 13
RadiusPole = 970 DiaDamper = 14.4 LocusDamper = 953 ShoeWidthMinor = 475
ShoeWidthMajor = 495 ShoeHeight = 65 PoleWidth = 315 Bso = 3
%}

% lower bound
options.lb = [2300 100 725 10 10 900 13 4 460 0 40 300 4]; 
% upper bound
options.ub = [2700 500 775 25 16 1050 18 10 490 20 80 350 6]; 
options.vartype = [2 2 2 1 1 2 1 2 2 2 2 2 2];
options.objfun = @TP_Baksan_maxwell_objfun;     % objective function handle
options.plotInterval = 100;                       % interval between two calls of "plotnsga". 
%oldresult=loadpopfile('populations.txt');
%options.initfun={@initpop, oldresult};
options.useParallel = 'yes'; 
options.poolsize = 13; 
result = nsga2(options);                % begin the optimization!