gen = [];
for i = 1:39
    fid =  fopen([pwd '\populations.Baksan.750\G' num2str(i) '.Baksan.750p.txt'],'r'); 
    datacell = textscan(fid, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f', 'Delimiter', '\t');
    datacell = cell2mat(datacell);
    gen = [gen; datacell];
end
data={};
for i = 1:16
    data{i} = gen(:,i);
end
