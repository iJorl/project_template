%SIMULATION.m
%--------------------------
function[] = simulation(graph, nodes, edges, sources, colonies, time, timestep)
%check all parameters
%--------------------------




%Simulation loop
%--------------------------
% for each timestep
%   for each colony
    % for each ant
    %   do ant_sim()

nrColonies = size(colonies,2)
    
for t=1:timestep:time
    for col=1:1:nrColonies
       for antI=1:1:colonies(col).nrAnts
           colonies(col).ants(antI) = ant_move(colonies(col).ants(antI), graph, sources, nodes, edges)
       end
    end
end
% return results
%--------------------------