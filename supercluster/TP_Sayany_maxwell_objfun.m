function [y, cons] = TP_Sayany_maxwell_objfun(x)
%*************************************************************************
% Objective function : Maxwell ANSYS
%*************************************************************************
y = [0,0];
cons = [];
w = getCurrentWorker;
mfile = 'EX_Sayany';
Voltage = 15750;
filepath = cd;

% create vbs-files for Maxwell
MW_CreatevbsFile(x, w, mfile);
% launch vbs-file for Maxwell
%comm = '!"C:\Program Files (x86)\Ansoft\Maxwell14.0\Maxwell.exe" -runscriptandexit ';
comm = '!"C:\Program Files\AnsysEM\AnsysEM19.2\Win64\ansysedt.exe" -runscriptandexit ';
comm = [comm '"' filepath '\maxwell\' mfile '.Opt."'];
if isempty(w)
    comm = [comm 'vbs"']; 
    eval(comm);
else
    comm = [comm num2str(w.ProcessId) '.vbs"']; 
    eval(comm);
end

% launch bat-file for closing windows Maxwell's error
% eval(['!call ' pwd '\maxwell\sendkeys.bat "Maxwell2Dlib" "{ENTER}"']);
% eval(['!call ' pwd '\maxwell\sendMaxwell.bat "Maxwell" "{ENTER}"']);
% eval(['!call ' pwd '\maxwell\sendMaxwell2DComEngine.bat "Maxwell2DComEngine" "{ENTER}"']);
% eval(['!call ' fullfile([filepath '\maxwell\sendMaxwell2DComEngine.bat ']) '"Maxwell2DComEngine" "{ENTER}"']);


% return Y: stator losses, stator core area and stator voltage     
if isempty(w)
    fid =  fopen(fullfile([filepath '\maxwell\temp\SolvedValues.Opt.txt']),'r');
else
    fid =  fopen(fullfile([filepath '\maxwell\temp\SolvedValues.Opt.', num2str(w.ProcessId), '.txt']),'r');
end

datacell = textscan(fid, '%s %s %f %f %f %f %f %f %f %f %f %f %f', 'Delimiter', '\t', ...
                    'TreatAsEmpty', {'Date', 'DGap[mm]', 'DYoke[mm]', ... 
                    'Bs2[mm]', 'Gap[mm]', 'SCore[m2]', 'Losses[W]', 'Voltage[V]'});

fclose(fid);

y(1)=datacell{7}(end); % stator volume
y(2)=(datacell{10}(end)+datacell{12}(end)+datacell{13}(end))*(Voltage/datacell{11}(end))^2; % stator and rotor losses
y(3)=1/datacell{11}(end); % rotor current

% check values
if y(2) < 5*10^5 
    y(2) = y(2)*10^3;
end    
if y(3) < 10^(-6) 
    y(3) = y(3)*10^3;
end
