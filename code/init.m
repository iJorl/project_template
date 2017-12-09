% INIT.m - the brain
%------------------------------------


%Setup INP vars
%-------------------------------------

const_phermons = 20;

[graph, nodes, edges] = gen_graph();
%graph{1}(1)
%graph
%nodes
%edges

draw(nodes)

sources  = gen_sources(nodes);
[colonies] = gen_colony(nodes);

%sources
%colonies


% Call Simulation Script
%-------------------------------------
simulation(graph, nodes, edges, sources, colonies, 400, 1, const_phermons);

%Analyse 
%------------------------------------- 

%Viz
%-------------------------------------