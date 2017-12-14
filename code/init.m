% INIT.m - the brain
%------------------------------------





%Setup INP vars
%-------------------------------------
%Ants Properties
const_phermons = 300; %phermons mean live time
antsPerColony  = 100;

%Time Properties
time        = 500; %overall duration of sim
timestep    = 1; 
timeInterval = 50;


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
simulation(graph, nodes, edges, sources,...
           colonies, ants, time, timestep, timeInterval,...
           const_phermons, draw_properties, strategy);

%Analyse 
%------------------------------------- 

%Viz
%-------------------------------------
%make_movie(draw_properties.frameNr-1)
