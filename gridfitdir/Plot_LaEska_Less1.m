% The rated values
rated = [1170325; 1/17133; 0.2614]; % LaEska 5 - 32
rated = [1.068922;  (1008360+46113+17089)*(15750/15676)^2; 1/15676]; % Sayany 25 - 45

data = [];
for i = 5:45
    fid =  fopen([pwd '\populations.Sayany.750\G' num2str(i) '.Sayany.750p.txt'],'r'); 
    datacell = textscan(fid, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f', 'Delimiter', '\t');
    datacell = cell2mat(datacell);
    data = [data; datacell];
    fclose all;
end

data = [data, data(:,14)./rated(1)];
data = [data, data(:,15)./rated(2)];
data = [data, data(:,16)./rated(3)];

inc = data(:,17:19) <=1; 
inc = sum(inc,2);
num = [];
for i = 1:length(inc)
    if inc(i) == 3
        num = [num; data(i,:)];
    end    
end
