function[] = init(graphname)
%graphname = 'python_sample';
% INIT.m - the brain
%------------------------------------


%Setup INP vars
%-------------------------------------
%Ants Properties
const_phermons = 30; %phermons mean live time
antsPerColony  = 200;
foodinit       = 200;
diffPop        = 2;

%Time Properties
time        = 1000; %overall duration of sim
timestep    = 1; 
timeInterval = 10;

% sim props
nrSim = 30;
RandStream.setGlobalStream(RandStream('mt19937ar','seed',42))

%drawProperties
draw_properties(1).draw     = 1; %should draw?
draw_properties(1).show     = 1; %show during sim
draw_properties(1).timestep = 1; %frameintervall
draw_properties(1).frameNr  = 0; %framecounter
draw_properties(1).showAnts = 0; % show ants?

% strategy

strategy.type = 'none';
%strategy.type = 'local';
%strategy.type = 'global'

[graph, nodes, edges, regen] = gen_graph(graphname);

%graph{1}(1)
%graph
%nodes
%edges


sources  = gen_sources(nodes, foodinit, regen);
[colonies] = gen_colony(nodes, antsPerColony, diffPop);
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
simobj.strategy(1)   = strategy;
Simulations = []
Simulations(1).data = [simobj, simobj, simobj];


simObjPrep = [simobj, simobj, simobj];
simObjPrep(2).strategy.type = 'local';
simObjPrep(3).strategy.type = 'global';
simObjPrep(1).strategy


for i=1:1:nrSim
    for j=1:1:3
        Simulations(i).data(j) = simObjPrep(j);  
    end
end
parfor (i=1:1:nrSim,4)
    strcat('running Simulation ', num2str(i))
    for j=1:1:3
        [Simulations(i).data(j).globalProd,...
        Simulations(i).data(j).colonyProd,...
        Simulations(i).data(j).sourceProd]= simulation(graph, nodes, edges, sources,...
           colonies, ants, time, timestep, timeInterval,...
           const_phermons, draw_properties, Simulations(i).data(j).strategy);    
    end
    
end

params.const_phermons = const_phermons;
parms.antsPerColony  = antsPerColony;
params.foodinit       = foodinit;
params.diffPop        = diffPop;
%Time Properties
params.time        = time; %overall duration of sim
params.timestep    = timestep; 
params.timeInterval = timeInterval;
params.graph = graphname;
% sim props
params.nrSim = nrSim;
%Analyse 
%------------------------------------- 
simulation_analysis(Simulations);
% get global productivity in right measurement
savename = strcat('simulation_',graphname);
save(strcat(strcat('matlabsaves/', savename),'.mat'), 'Simulations','edges','params', 'nodes','sources','colonies');
%Viz
%-------------------------------------
%make_movie(draw_properties.frameNr-1)
