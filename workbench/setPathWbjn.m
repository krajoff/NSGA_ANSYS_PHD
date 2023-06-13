function setPathWbjn(namefile, vbsfile) 
path = fullfile(pwd, 'setPathWbjn.m');
fin = fopen(namefile,'r');
fout = fopen('temp.wbjn','w');
while ~feof(fin)
  str = fgetl(fin);
  if ~isempty(strfind(str, 'workbench'))
    str = strcat('"', regexprep(path, 'setPathWbjn.m', ''), vbsfile, '"');
  end
  fprintf(fout, '%s\n', str); 
end
fclose(fin);
fclose(fout);
delete (namefile);
movefile('temp.wbjn', namefile);
end


