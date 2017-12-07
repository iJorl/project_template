%SIMULATION.m
%--------------------------
function[] = simulation(graph, nodes, edges, sources, colonies, time, timestep, const_phermons)
%check all parameters
%--------------------------




%Simulation loop
%--------------------------
% for each timestep
%   for each colony
    % for each ant
    %   do ant_sim()

nrColonies = size(colonies,2);


colonyProd = [];
for i=1:1:nrColonies
    colonyProd(i) = [0];
end
for t=1:timestep:time
    for col=1:1:nrColonies
        % move ants
        for antI=1:1:colonies(col).nrAnts
           [colonies(col).ants(antI),sources,edges] = ant_move(colonies(col).ants(antI), sources, nodes, edges);
            if colonies(col).ants(antI).pos == colonies(col).pos
                colonyProd(col,end) = colonyProd(col,end) + colonies(col).ants(antI).food; 
            end
        end

       %update phermeons
       for p=1:1:length(edges)
           edges(p).phermons = edges(p).phermons * (1 - 1/const_phermons);
       end
       
       %measure productivity
       if mod(t,20) == 0
           % add a new entry
           colonyProd(col,end+1) = 0;
       end
       
        
    end
end
colonies(1).ants(7).path
nodes(8)
colonyProd
sources