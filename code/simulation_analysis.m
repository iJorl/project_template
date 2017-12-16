function [] = simulation_analysis(Simulations)

ynone = [[]]
ylocal = [[]]
yglobal = [[]]
x = [1:1:length(Simulations(1).data(1).globalProd.intervals)]
nrSim = length(Simulations)
nrcols = 1;
for i=1:1:nrSim
    % global productivity
    ynone(i,:)      = Simulations(i).data(1).globalProd.intervals;
    ylocal(i,:)     = Simulations(i).data(2).globalProd.intervals;
    yglobal(i,:)    = Simulations(i).data(3).globalProd.intervals;
    
    % efficiency per colony
    for j=4:1:4
        ynone(i,:)      = Simulations(i).data(1).colonyProd(j).intervals;
        ylocal(i,:)     = Simulations(i).data(2).colonyProd(j).intervals;
        yglobal (i,:)   = Simulations(i).data(3).colonyProd(j).intervals;
    end
    % population per colony
    
    
end

hold on
errorbar(x,mean(ynone), std(ynone), 'k', 'Linewidth', 2);
errorbar(x,mean(ylocal), std(ylocal), 'b', 'Linewidth', 2);
errorbar(x,mean(yglobal), std(yglobal), 'r', 'Linewidth', 2);
hold off