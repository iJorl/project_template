% GEN_GRAPH
%---------------------------------------

function [graph, nodes, edges] = gen_graph()
n = 4; m = 3;
% graph stores index of adj. edges
graph = {[1];[1, 2, 3];[2];[3]};
% node stores: type and index
nodes = [];
%for i = 1:n
%    nodes(i) = [0, 0]
%end
% type 1 = nest, type 2 = food, type 0 = traffic node
nodes = [
        [1,1];
        [0,0];
        [2,1];
        [2,2];
        ];

%edge stores begin, end, weight, phermons
edges = [
        [1, 2, 1, 0];
        [2, 3, 1, 0];
        [2, 4, 1, 0];
        ];
