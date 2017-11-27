% INIT.m - the brain
%------------------------------------


%Setup INP vars
%-------------------------------------

[graph, nodes, edges] = gen_graph();
%graph{1}(1)
%graph
%nodes
%edges

sources  = gen_sources();
[colonies] = gen_colony();

%sources
%colonies


% Call Simulation Script
%-------------------------------------
simulation(graph, nodes, edges, sources, colonies, 300, 1);

%Analyse 
%-------------------------------------

%Viz
%-------------------------------------