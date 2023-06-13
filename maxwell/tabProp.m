%% Checking existence 
station = ["EX_Djerdap.vbs"; "EX_LaEska.vbs"; "EX_Nuoja.vbs"; ...
           "EX_Plyvna.vbs"; "EX_PuntaNegra.vbs"; "EX_SaoJoao.vbs"; ...
           "EX_Saratovskya.vbs"; "EX_Sayany.vbs"; "EX_Taini.vbs"; ...
           "EX_Vozhsky.vbs"; "EX_Votkinsckaya.vbs"; "EX_Baksan.vbs"];
filename = table(station);
idx = isfile(filename.station);
exfile = filename(idx, :);
%% 
path = fullfile(pwd, 'setPath.m');
fin = fopen(exfile.station, 'r');
%writetable(T, [exfile.station '.txt'], 'Delimiter', ' ');
%mout = fopen('temp.vbs', 'w');
%fstr = 'MainFolder';
cnt = 1;
maxrow = 60;
varName = cell(maxrow,1);
varValue = cell(maxrow,1);
while ~feof(fin)
  str = fgetl(fin);
  if contains(str, "=") && cnt <= maxrow
     str = char(str(~isspace(str)));
     idx = strfind(str, "=");
     idn = strfind(str, "'");
     varName{cnt} = str(1:idx-1);
     varValue{cnt} = str(idx+1:idn-1);
     if ~isnan(str2double(varValue{cnt}))
        varValue{cnt} = str2double(varValue{cnt});
     else
         
     end    
     cnt = cnt + 1;     
  end
end
T =  array2table(varValue', 'VariableNames', varName');
fclose(fin);