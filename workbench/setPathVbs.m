function setPathVbs(namefile) 
path = fullfile(pwd, 'setPathVbs.m');
fin = fopen(namefile,'r');
fout = fopen('temp.vbs','w');
while ~feof(fin)
  str = fgetl(fin);
  if ~isempty(strfind(str, 'MainFolder = '))
    str = strcat('MainFolder = "', ...
    regexprep(path, 'setPathVbs.m', ''), '"');
  end
  fprintf(fout, '%s\n', str); 
end
fclose(fin);
fclose(fout);
delete (namefile);
movefile('temp.vbs', namefile);
end


