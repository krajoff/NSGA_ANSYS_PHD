close all
rms = zeros(8,10);
time = data(2:end,1);
ts = mean(diff(time));
l = size(time,1);
fs = 1/ts;
fn = fs/2;
fv = linspace(0, 1, fix(l/2)+1)*fn;
figure('Name', 'Compass Plot', 'Position', [50, 50, 1150, 700])
%{
for i = 1:10
    value = data(2:end,i+1);                                             
    Iv = 1:length(fv);
    A = zeros(l/2+1, 0);
    P = zeros(l/2+1, 0);
    Y = abs(fft(value)/l);
    Phase = angle(fft(value)/l);
    P1 = Y(1:l/2+1);
    Phase1 = Phase(1:l/2+1);
    f = fs*(0:(l/2))/l;
    P1(2:end-1) = 2*P1(2:end-1);
    
    Phase1 = Phase1*180/pi-45;    
    P1 = P1/2^0.5;
    rms(1,i) = P1(7);
    rms(2,i) = Phase1(7);
    rms(3,i) = P1(13);
    rms(4,i) = Phase1(13);
    rms(5,i) = P1(19);
    rms(6,i) = Phase1(19);
    rms(7,i) = P1(25);
    rms(8,i) = Phase1(25);
    pvec(0,0,rms(7,i),rms(8,i), '#D95319', '-', 2)
    hold on
%    plot(f,P1) 
%    hold off
end
ylim([-100 100])
xlim([-100 100])
for i = 1:10
    pvec(0,0,measures(1,i),measures(2,i)+90, '#0072BD', '--', 2)
    hold on
end
hold off
ax = gca; set(gca, 'FontSize', 12)
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
box off
saveas(gcf, 'DamperCurrentPolarPlot1200Hz.png')
%}
for i = 1:10
    value = data(2:end,i+1);                                             
    Iv = 1:length(fv);
    A = zeros(l/2+1, 0);
    P = zeros(l/2+1, 0);
    Y = abs(fft(value)/l);
    Phase = angle(fft(value)/l);
    P1 = Y(1:l/2+1);
    Phase1 = Phase(1:l/2+1);
    f = fs*(0:(l/2))/l;
    P1(2:end-1) = 2*P1(2:end-1);
    Phase1 = Phase1-pi/4;    
    P1 = P1/2^0.5;
    rms(1,i) = P1(7);
    rms(2,i) = Phase1(7);
    rms(3,i) = P1(13);
    rms(4,i) = Phase1(13);
    rms(5,i) = P1(19);
    rms(6,i) = Phase1(19);
    rms(7,i) = P1(25);
    rms(8,i) = Phase1(25);
    polararrow(rms(7,i),rms(8,i), '#D95319', '-')
    hold on
%    plot(f,P1) 
%    hold off
end
for i = 1:10
    polararrow(measures(1,i),measures(2,i)*pi/180+pi/2, '#0072BD', '--')
    hold on
end
for i = 1:10
    polararrow(damperCurrents_KB(1,i),damperCurrents_KB(2,i)*pi/180+pi/2, '#0072BD', ':')
    hold on
end
hold off
ax = gca; set(gca, 'FontSize', 12)
box off
thetaticks([0:15:360])
saveas(gcf, 'DamperCurrentPolarPlot1200Hz.png')








%{
figure('Name', 'CurrentDamper', 'Position', [50, 50, 1150, 700])
for i = 2:6
    values = data(2:end,i);
    plot(time, values, '-',  'LineWidth' , 1.5, 'DisplayName', ['Ток в демпфере №' num2str(i)]);
    hold on
end
grid on
ax = gca; set(gca, 'FontSize', 12)
hold off
figure('Name', 'CurrentDamper1200Hz', 'Position', [50, 50, 800, 700])
plot(1:10, rms(7,1:10), '-s', 'Color', '#D95319', 'LineWidth', 2, 'MarkerFaceColor' , '#D95319')
hold on
plot(1:10, measures(1,1:10), '-s', 'Color', '#0072BD', 'LineStyle', '--', 'LineWidth', 2, 'MarkerFaceColor' , '#0072BD')
grid on
box off
ylim([0 100])
ax = gca; set(gca, 'FontSize', 15)
saveas(gcf, 'DamperCurrentPlot1200Hz.png')
%}