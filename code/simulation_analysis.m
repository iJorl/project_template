function [] = simulation_analysis(Simulations)

ynone = [[]]
ylocal = [[]]
yglobal = [[]]
x = [1:1:length(Simulations(1).data(1).globalProd.intervals)];
nrSim = length(Simulations);
nrcols = 1;
for i=1:1:nrSim
    % global productivity
    ynone(i,:)      = Simulations(i).data(1).globalProd.intervals;
    ylocal(i,:)     = Simulations(i).data(2).globalProd.intervals;
    yglobal(i,:)    = Simulations(i).data(3).globalProd.intervals;
    
    % efficiency per colony
    for j=4:1:4
        %ynone(i,:)      = Simulations(i).data(1).colonyProd(j).intervals;
        %ylocal(i,:)     = Simulations(i).data(2).colonyProd(j).intervals;
        %yglobal (i,:)   = Simulations(i).data(3).colonyProd(j).intervals;
    end
    % population per colony
    
    
end

% 3 diff figures for the diff. strategies
hold on
set(gca,'FontSize',16);
xlabel('Time'),
ylabel('Global productivity');
xlim([0 100])
ylim([0 .05])
errorbar(x,mean(ynone), std(ynone), 'k', 'Linewidth', 2);
hold off
figure();
hold on
set(gca,'FontSize',16);
xlabel('Time'),
ylabel('Global productivity');
xlim([0 100])
ylim([0 .05])
errorbar(x,mean(ylocal), std(ylocal), 'b', 'Linewidth', 2);
hold off
figure();
hold on
set(gca,'FontSize',16);
xlabel('Time'),
ylabel('Global productivity');
xlim([0 100])
ylim([0 .05])
errorbar(x,mean(yglobal), std(yglobal), 'r', 'Linewidth', 2);
hold off
figure();



% create plus minus
diffLocal = [[]];
diffGlobal = [[]];
for i=1:1:nrSim
    % global productivity
    diffLocal(i,:)      = Simulations(i).data(2).globalProd.intervals - Simulations(i).data(1).globalProd.intervals;
    diffGlobal(i,:)     = Simulations(i).data(3).globalProd.intervals - Simulations(i).data(1).globalProd.intervals;
end

hold on
set(gca,'FontSize',16);
xlabel('Time'),
ylabel('Global productivity');
xlim([0 100])
ylim([-0.01 .01])
%errorbar(x,mean(ynone), std(ynone), 'k', 'Linewidth', 2);
errorbar(x,mean(diffLocal), std(diffLocal), 'b', 'Linewidth', 2);
errorbar(x,mean(diffGlobal), std(diffGlobal), 'r', 'Linewidth', 2);
hold off
figure()


pnone = [[]];
plocal = [[]];
pglobal = [[]];
for i=1:1:nrSim
    % global productivity
    i
    pnone(i,:) =  Simulations(i).data(1).colonyProd(1).populationInterval
    plocal(i,:) =   Simulations(i).data(2).colonyProd(3).populationInterval;
    pglobal(i,:) =  Simulations(i).data(3).colonyProd(3).populationInterval;      
    
end


hold on
set(gca,'FontSize',16);
xlabel('Time'),
ylabel('global strategy population');
xlim([0 250])
ylim([0 400])
errorbar(1:1:length(pnone),mean(pglobal), std(pglobal), 'r', 'Linewidth', 2);

hold off

figure()

hold on
set(gca,'FontSize',16);
xlabel('Time'),
ylabel('local strategy population');
xlim([0 250])
ylim([0 300])
errorbar(1:1:length(pnone),mean(plocal), std(plocal), 'b', 'Linewidth', 2);

hold off

