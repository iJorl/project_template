% INIT.m - the brain
%------------------------------------


%Setup INP vars
%-------------------------------------

const_phermons = 10;

[graph, nodes, edges] = gen_graph();

%graph{1}(1)
%graph
%nodes
%edges


sources  = gen_sources(nodes);
[colonies] = gen_colony(nodes);
[ants] = gen_ants(colonies);

%sources
%colonies

% Call Simulation Script
%-------------------------------------
simulation(graph, nodes, edges, sources, colonies, ants, 1000, 1, const_phermons);
%make_movie(49)
%Analyse 
%------------------------------------- 

%Viz
%-------------------------------------