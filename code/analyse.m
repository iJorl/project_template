function [] = analyse(colonyProd, sourceProd)
clf('reset');
hold on
title('Productivity measure of ant colonies')
xlabel('time') % x-axis label
ylabel('Productivity [food/time]') % y-axis label
for i=1:1:length(colonyProd)
    colonyProd(i).intervals;
    plot([1:1:length(colonyProd(i).intervals)],colonyProd(i).intervals, 'DisplayName', strcat('Colony', num2str(i)))
end
legend('Location','southeast')
legend('boxoff')
legend('show');

hold off
saveas(gcf,strcat('exports/plot_' ,strcat('1','.png')));
figure();


%
clf('reset');
hold on
title('Ant measure of sources')
xlabel('time') % x-axis label
ylabel('Productivity [food/time]') % y-axis label
for i=1:1:length(sourceProd)
    sourceProd(i).intervals;
    plot([1:1:length(sourceProd(i).intervals)],sourceProd(i).intervals, 'DisplayName', strcat('Source', num2str(i)))
end
legend('Location','southeast')
legend('boxoff')
legend('show');

hold off
saveas(gcf,strcat('exports/plot_' ,strcat('2','.png')));
figure();