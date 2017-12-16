function [] = analyse(colonyProd, sourceProd, globalProd, strategy)



clf('reset');
hold on
title('Productivity measure of ant colonies')
xlabel('time') % x-axis label
ylabel('Productivity [food per ant /time]') % y-axis label
for i=1:1:length(colonyProd)
    colonyProd(i).intervals;
    plot([1:1:length(colonyProd(i).intervals)],colonyProd(i).intervals, 'DisplayName', strcat('Colony', num2str(i)))
end
legend('Location','southeast')
legend('boxoff')
legend('show');

hold off
st = strcat(strcat('exports/plot_',strategy.type) ,strcat('1','.png'));
saveas(gcf,st);
figure();


clf('reset');
hold on
title('Productivity measure over all ant colonies')
xlabel('time') % x-axis label
ylabel('Productivity [food per ant /time]') % y-axis label
   
plot([1:1:length(globalProd.intervals)],globalProd.intervals, 'DisplayName', 'Global Productivity')

legend('Location','southeast')
legend('boxoff')
legend('show');

hold off
saveas(gcf,strcat(strcat('exports/plot_',strategy.type) ,strcat('global','.png')));
figure();



%
clf('reset');
hold on
title('Ant measure of sources')
xlabel('time') % x-axis label
ylabel('number of ants') % y-axis label
for i=1:1:length(sourceProd)
    sourceProd(i).intervals;
    plot([1:1:length(sourceProd(i).intervals)],sourceProd(i).intervals, 'DisplayName', strcat('Source', num2str(i)))
end
legend('Location','southeast')
legend('boxoff')
legend('show');

hold off
saveas(gcf,strcat(strcat('exports/plot_',strategy.type) ,strcat('2','.png')));
figure();





clf('reset');
hold on
title('Ant population of colonies')
xlabel('time') % x-axis label
ylabel('Population') % y-axis label
for i=1:1:length(colonyProd)
    colonyProd(i).populationInterval = colonyProd(i).populationInterval(1:end-1);
    plot([1:1:length(colonyProd(i).populationInterval)],colonyProd(i).populationInterval, 'DisplayName', strcat('Colony', num2str(i)));
end
legend('Location','southeast');
legend('boxoff');
legend('show');

hold off
saveas(gcf,strcat(strcat('exports/plot_',strategy.type) ,strcat('3','.png')));
figure();