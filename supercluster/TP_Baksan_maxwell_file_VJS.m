%*************************************************************************
% Objective function : Maxwell ANSYS
%*************************************************************************
x = [2695 114 747 23.7958 10.1485 1029 14 6 465 9 79 346 4];

w = getCurrentWorker;
mfile = 'EX_Baksan';
Voltage = 6300;
filepath = cd;

% create vbs-files for Maxwell
MW_CreatevbsFile(x, w, mfile);
