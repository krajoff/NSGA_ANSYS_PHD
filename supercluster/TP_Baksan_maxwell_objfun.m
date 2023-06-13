function [y, cons] = TP_Baksan_maxwell_objfun(x)
%*************************************************************************
% Objective function : Maxwell ANSYS
%*************************************************************************
y = [0,0];
cons = [];
w = getCurrentWorker;
mfile = 'EX_Baksan';
Voltage = 6300;
filepath = cd;
hs012 = round(2*52*11.5/(x(4)-5.1)+6.9+2.95+5.95+(5.5+.5));

% create vbs-files for Maxwell
MW_CreatevbsFile(x, w, mfile, hs012);
comm = '!"C:\Program Files\AnsysEM\AnsysEM19.2\Win64\ansysedt.exe" -runscriptandexit ';
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
if VoltageValue > 5*10^4
    VoltageValue = VoltageValue/10^3;
end
y(1) = datacell{7}(end); % stator volume
y(2) = (datacell{10}(end)+datacell{12}(end)+datacell{13}(end))*(Voltage/VoltageValue)^2; % stator and rotor losses
y(3) = 1/VoltageValue; % rotor current
y(4) = datacell{14}(end); % THD
y(5) = datacell{16}(end); % Xsd
