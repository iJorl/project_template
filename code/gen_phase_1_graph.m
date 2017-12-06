% GEN_GRAPH
%---------------------------------------

function [graph, nodes, edges] = gen_graph()
n = 4; m = 3;
% graph stores index of adj. edges
graph = {[1];[1, 2, 3];[2];[3]};
% access with graph{nodeNr}(edgeNr)

% node stores: type, link, edges
% type 1 = colony, type 2 = food, type 0 = traffic node
% specify graph with 4 nodes
nodes(1).type = 'colony';
nodes(1).link = 0;
nodes(1).edges = [1];

nodes(2).type = 'traffic';
nodes(2).link = 0;
nodes(2).edges = [1,2,3];

nodes(3).type = 'source';
nodes(3).link = 0;
nodes(3).edges = [2];

nodes(4).type = 'source';
nodes(4).link = 0;
nodes(4).edges = [3];


%edge stores begin, end, weight, phermons
edges = [];

edges(1).from       = 1;
edges(1).to         = 2;
edges(1).weight     = 10;
edges(1).phermons   = 0;

edges(2).from       = 2;
edges(2).to         = 3;
edges(2).weight     = 6;
edges(2).phermons   = 0;

edges(3).from       = 2;
edges(3).to         = 4;
edges(3).weight     = 3;
edges(3).phermons   = 0;

%graph
%nodes
%edges
