% INIT.m - the brain
%------------------------------------





%Setup INP vars
%-------------------------------------
%Ants Properties
const_phermons = 300; %phermons mean live time
antsPerColony  = 200;

%Time Properties
time        = 1000; %overall duration of sim
timestep    = 1; 
timeInterval = 50;

RandStream.setGlobalStream(RandStream('mt19937ar','seed',42))

%drawProperties
draw_properties(1).draw     = 1; %should draw?
draw_properties(1).show     = 1; %show during sim
draw_properties(1).timestep = 1; %frameintervall
draw_properties(1).frameNr  = 0; %framecounter
draw_properties(1).showAnts = 0; % show ants?

% strategy

%strategy.type = 'none';
strategy.type = 'local';
%strategy.type = 'global'

[graph, nodes, edges] = gen_graph();

%graph{1}(1)
%graph
%nodes
%edges


sources  = gen_sources(nodes);
[colonies] = gen_colony(nodes, antsPerColony);
[ants] = gen_ants(colonies);

for i=1:1:length(nodes)
    if strcmp(nodes(i).type, 'colony') == 1
        nodes(i).type = 'source';
    end
end


%sources
%colonies

% Call Simulation Script
%-------------------------------------
simobj.globalProd = [];
simobj.colonyProd = [];
simobj.sourceProd = [];
simobj.type       = 'none';
Simulations = []
Simulations(1).data = [simobj, simobj, simobj];


simObjPrep = [simobj, simobj, simobj];
simObjPrep(2).type = 'local';
simObjPrep(3).type = 'global';

nrSim = 1;

for i=1:1:nrSim
    Simulations(i).data = simObjPrep;
    for j=1:1:3
        [Simulations(i).data(j).globalProd,...
        Simulations(i).data(j).colonyProd,...
        Simulations(i).data(j).sourceProd]= simulation(graph, nodes, edges, sources,...
           colonies, ants, time, timestep, timeInterval,...
           const_phermons, draw_properties, strategy);    
    end
    
end
%Analyse 
%------------------------------------- 

analysisObj.avg = [];
analysisObj.min = [];
analysisObj.max = [];

analysis(1).data = [analysisObj, analysisObj, analysisObj];

sizeOfSim = length(Simulations(1).data(1).globalProd.intervals);
for k=1:1:sizeOfSim
 
     for j=1:1:3
        savg = 0;
        smax = Simulations(k).data(j).globalprod.intervals(1);
        smin = Simulations(k).data(j).globalprod.intervals(1);
       
        for i=1:1:sizeOfSim
            a = Simulations(k).data(j).globalProd.intervals(i);
            s = s + a
            sma = max(sma, a);
            smi = min(smi, a);           
        end
    end
    
    
    s = 0;
    sma = Simulations(i).globalProd.intervals(k);
    smi = sma;
    for i=1:1:nrSim
        s = s + Simulations(i).globalProd.intervals(k);
        sma = max(sma, Simulations(i).globalProd.intervals(k));
        smi = min(smi, Simulations(i).globalProd.intervals(k));
    end
    prod.avg(k) = s / nrSim;
    prod.max(k) = sma;
    prod.min(k) = smi;
end
Simulations(1).globalProd.intervals
prod
plot(1:1:length(Simulations(1).globalProd.intervals),prod.avg,...
     1:1:length(Simulations(1).globalProd.intervals),prod.max,...
     1:1:length(Simulations(1).globalProd.intervals),prod.min)
%Viz
%-------------------------------------
%make_movie(draw_properties.frameNr-1)
