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

for t=1:timestep:time
    for col=1:1:nrColonies
        % move ants
        for antI=1:1:colonies(col).nrAnts
           [colonies(col).ants(antI),sources,edges] = ant_move(colonies(col).ants(antI), sources, nodes, edges);
        end

       %update phermeons
       for p=1:1:length(edges)
           edges(p).phermons = edges(p).phermons * (1 - 1/const_phermons);
       end
       
        
    end
end
