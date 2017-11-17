%SIMULATION.m
%--------------------------
function[] = simulation(graph, nodes, edges, sources, colonies, ants, time, timestep)
%check all parameters
%--------------------------




%Simulation loop
%--------------------------
% for each timestep
%   for each colony
    % for each ant
    %   do ant_sim()
for t=1:timestep:time
    for col = 1:1:size(colonies)
        for ant=1:1:colonies(col, 2)
        
           % do ant stuff here
            
        end
    end
end
% return results
%--------------------------