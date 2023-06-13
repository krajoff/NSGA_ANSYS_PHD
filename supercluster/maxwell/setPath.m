function setPath(namefile) 
path = fullfile(pwd, 'setPath.m');
fin = fopen(namefile,'r');
fout = fopen('temp.vbs','w');
fstr = 'MainFolder';
while ~feof(fin)
  str = fgetl(fin);
  if contains(str, fstr) && contains(str, '= "') 
     str = strcat(fstr, '      = "', ...
     regexprep(path, 'setPath.m', ''), '"');
  end
  fprintf(fout, '%s\n', str); 
end
fclose(fin);
fclose(fout);
delete (namefile);
movefile('temp.vbs', namefile);
end


