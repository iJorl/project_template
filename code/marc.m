ant = gen_ant(1,1);

[graph, nodes, edges] = gen_graph();

sources = gen_sources();

for i=0:5000
    [ant,sources,edges] = ant_move(ant,sources,nodes,edges);
end

sources(1)
sources(2)
