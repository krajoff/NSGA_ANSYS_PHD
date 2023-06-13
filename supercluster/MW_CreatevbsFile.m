%*************************************************************************
% Create vbs-file for Maxwell
%*************************************************************************
function MW_CreatevbsFile(x, w, mfile, Hs012, PoleHeight, BrwSrw, Poles)
    filepath = cd;
    fin =  fopen(fullfile([filepath '\maxwell\' mfile '.vbs']), 'r');
if isempty(w)
    fout = fopen(fullfile([filepath '\maxwell\' mfile '.Opt.vbs']), 'w');
else
    fout = fopen(fullfile([filepath '\maxwell\' mfile '.Opt.' num2str(w.ProcessId) '.vbs']), 'w');
end
counter = 0;
Rpole = x(1)/2-x(5)-x(11)-PoleHeight;
WidthPole = round(2*(Rpole*tan(pi/Poles)-BrwSrw));

while ~feof(fin);
  counter = counter + 1; 
  str = fgetl(fin);
  switch counter
    case 24
       str = ['IncTitle = ".Opt"'];    
    case 29
       str = ['DiaGap = ',		   num2str(x(1)), 	' '' 1.Core diameter on gap side [mm]'];
	case 30
       str = ['LengthCore = ',	   num2str(x(3)), 	' '' 3.Stator core length [mm]'];       
    case 34
       str = ['Bs2 = ',			   num2str(x(4)), 	' '' 4.Slot body width [mm]'];
	case 42
       str = ['DiaYoke = ',		   num2str(x(1)+2*Hs012+2*x(2)), 	' '' 2.Core diameter on yoke side [mm]'];   
    case 44
       str = ['AirGap = ',		   num2str(x(5)), 	' '' 5.Air gap [mm]'];
    case 61
       str = ['RadiusPole = ',	   num2str(x(6)), 	' '' 6.Pole radius [mm]'];
    case 62 
       str = ['DiaDamper = ',	   num2str(x(7)), 	' '' 7.Pole damper diameter [mm]'];	
    case 63	  
       str = ['LocusDamper = ',	   num2str(x(6) - x(7)/2 - x(8)), 	' '' 8.Locus damper radius [mm] '];		   
    case 66
       str = ['ShoeWidthMinor = ', num2str(x(9)), 	' '' 9.Minor pole shoe width [mm]'];
	case 67
       str = ['ShoeWidthMajor = ', num2str(x(9) + x(10)),	' '' 10.Major pole shoe width [mm]'];   
    case 68
       str = ['ShoeHeight = ',	   num2str(x(11)),	' '' 11.Pole shoe height [mm]'];
    case 69
       str = ['PoleWidth = ',  	   num2str(WidthPole - x(12)),	' '' 12.Pole body width [mm]']; 
	case 74
       str = ['Bso = ',  		   num2str(x(13)),  ' '' 13.Slot opening width [mm]']; 
  end  
  if ~isempty(w)
    switch counter
    case 24
       str = ['IncTitle = ".Opt.',  num2str(w.ProcessId), '"'];  
    end    
  end
  fprintf(fout, '%s\n', str);
end
fclose(fin);
fclose(fout);
% Create files SolvedValues
if ~isempty(w)
    if ~exist(fullfile([filepath '\maxwell\temp\SolvedValues.Opt.' num2str(w.ProcessId) '.txt']), 'file')
        fid = fopen(fullfile([filepath '\maxwell\temp\SolvedValues.Opt.' num2str(w.ProcessId) '.txt']),'w');
        fid = fclose(fid);
    end
else 
    if ~exist(fullfile([filepath '\maxwell\temp\SolvedValues.Opt.txt']), 'file')
        fid = fopen(fullfile([filepath '\maxwell\temp\SolvedValues.Opt.txt']),'w');
        fid = fclose(fid);
    end
end
