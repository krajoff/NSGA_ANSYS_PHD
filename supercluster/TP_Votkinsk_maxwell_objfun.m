function [y, cons] = TP_Votkinsk_maxwell_objfun(x)
%*************************************************************************
% Objective function : Maxwell ANSYS
%*************************************************************************
y = [0,0];
cons = [];
w = getCurrentWorker;
mfile = 'EX_Votkinsckaya';
Voltage = 13800;

% create vbs-files for Maxwell
MW_CreatevbsFile(x, w, mfile);

% launch vbs-file for Maxwell
%comm = '!"C:\Program Files (x86)\Ansoft\Maxwell14.0\Maxwell.exe" -runscriptandexit ';
comm = '!"C:\Program Files\AnsysEM\AnsysEM19.1\Win64\ansysedt.exe" -runscriptandexit ';
comm = [comm '"' pwd '\maxwell\' mfile '.Opt."'];
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

% return Y: stator losses, stator core area and stator voltage     
if isempty(w)
    fid =  fopen([pwd '\maxwell\temp\SolvedValues.Opt.txt'],'r');
else
    fid =  fopen([pwd '\maxwell\temp\SolvedValues.Opt.', num2str(w.ProcessId), '.txt'],'r');
end

datacell = textscan(fid, '%s %s %f %f %f %f %f %f %f %f %f %f %f', 'Delimiter', '\t', ...
                    'TreatAsEmpty', {'Date', 'DGap[mm]', 'DYoke[mm]', ... 
                    'Bs2[mm]', 'Gap[mm]', 'SCore[m2]', 'Losses[W]', 'Voltage[V]'});

fclose(fid);
y(1)=datacell{7}(end); % stator volume
y(2)=(datacell{10}(end)+datacell{12}(end)+datacell{13}(end))*(Voltage/datacell{11}(end)); % stator and rotor losses
y(3)=1/datacell{11}(end); % rotor current