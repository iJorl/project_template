% INIT.m - the brain
%------------------------------------


%Setup INP vars
%-------------------------------------

[graph, nodes, edges] = gen_graph()
%graph{1}(1)
graph
nodes
edges

sources  = gen_sources();
[colonies, ants] = gen_colony();

sources
colonies
ants

% Call Simulation Script
%-------------------------------------
simulation(graph, nodes, edges, sources, colonies, ants, 1, 0.1)

%Analyse 
%-------------------------------------

%Viz
%-------------------------------------