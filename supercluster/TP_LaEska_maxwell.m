%*************************************************************************
%   Test Problem : 'ANSYS Workbench'
%   Reference : [1] Deb K, Pratap A, Agarwal S, et al. A fast and elitist 
%   multiobjective genetic algorithm NSGA-II[J]. Evolutionary Computation. 
%   2002, 6(2): 182-197.
%*************************************************************************
options = nsgaopt();                    % create default options structure
options.popsize = 1000;                 % populaion size 750
options.maxGen  = 30;                   % max generation 40

options.numObj = 3;                     % number of objectives
options.numVar = 13;                    % number of design variables
options.numCons = 0;                    % number of constraints

%  Initial data: 
%  DiaGap = 10840 DiaYoke = 11820 LengthCore = 3000 Bs2 = 19 AirGap = 25
%  RadiusPole = 1780.8 DiaDamper = 16.4 LocusDamper = 1764.6 ShoeWidthMinor = 515
%  ShoeWidthMajor = 515 ShoeHeight = 70 PoleWidth = 390 Bso = 4

% lower bound
options.lb = [9800 100 2950 15 20 1700 14 4 495 0 55 2 3]; 
% upper bound
options.ub = [11500 400 3050 25 30 1900 19 10 535 20 85 75 6]; 
options.vartype = [2 2 2 1 1 2 1 2 2 2 2 2 2];
options.objfun = @TP_LaEska_maxwell_objfun;       % objective function handle
options.plotInterval = 100;                       % interval between two calls of "plotnsga". 
oldresult=loadpopfile('populations.txt');
options.initfun={@initpop, oldresult};
options.useParallel = 'yes'; 
options.poolsize = 10; 
result = nsga2(options);                          % begin the optimization!