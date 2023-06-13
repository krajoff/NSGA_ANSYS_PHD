function [y, cons] = TP_LaEska_maxwell_objfun(x)
%*************************************************************************
% Objective function : Maxwell ANSYS
%*************************************************************************
y = [0,0];
cons = [];
w = getCurrentWorker;
mfile = 'EX_LaEska';
Voltage = 17000;
filepath = cd;
hs012 = round(2*10.9*72.6/(x(4)-8.1)+12.9+6.45+5.75+(12+1)); % Hs012 = 183.3 mm
PoleHeight = 280;
BrwSrw = 100+6;
Poles = 48;

% create vbs-files for Maxwell
pause(abs(random('Normal', 3, 3)));
MW_CreatevbsFile(x, w, mfile, hs012, PoleHeight, BrwSrw, Poles);
comm = '!"C:\Program Files\AnsysEM\AnsysEM19.5\Win64\ansysedt.exe" -runscriptandexit ';
% comm = '!"D:\ANSYS\ES2019R2\AnsysEM19.4\Win64\ansysedt.exe" -runscriptandexit ';
comm = [comm '"' filepath '\maxwell\' mfile '.Opt."'];
if isempty(w)
    comm = [comm 'vbs"']; 
    eval(comm);
else
    comm = [comm num2str(w.ProcessId) '.vbs"']; 
    eval(comm);
end

% return Y: stator losses, stator core area and stator voltage     
if isempty(w)
    fid =  fopen(fullfile([filepath '\maxwell\temp\SolvedValues.Opt.txt']),'r');
else
    fid =  fopen(fullfile([filepath '\maxwell\temp\SolvedValues.Opt.', num2str(w.ProcessId), '.txt']),'r');
end

datacell = textscan(fid, '%s %s %f %f %f %f %f %f %f %f %f %f %f %f %f %f', 'Delimiter', '\t', ...
                    'TreatAsEmpty', {'Date', 'DGap[mm]', 'DYoke[mm]', ... 
                    'Bs2[mm]', 'Gap[mm]', 'SCore[m2]', 'Losses[W]', 'Voltage[V]'});
fclose(fid);

VoltageValue = datacell{11}(end);
if VoltageValue > 10^5
    VoltageValue = VoltageValue/10^3;
end

y(1) = (datacell{10}(end)+datacell{12}(end)+datacell{13}(end))*(Voltage/VoltageValue)^2; % stator and rotor losses
y(2) = 1/VoltageValue; % rotor current
y(3) = datacell{14}(end); % THD
% y(5) = datacell{16}(end); % Xsd
% y(1) = datacell{7}(end); % stator volume