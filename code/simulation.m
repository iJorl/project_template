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

nrColonies = size(colonies,2);
nrants1 = [];
nrants2 = [];
ti = [1:timestep:time];
for t=1:timestep:time
    for col=1:1:nrColonies
       for antI=1:1:colonies(col).nrAnts
           [colonies(col).ants(antI),sources,edges] = ant_move(colonies(col).ants(antI), sources, nodes, edges);
           nrants1(t) = sources(1).antNr;
           nrants2(t) = sources(2).antNr;
       end
    end
end
% return results
%--------------------------
for i=length(nrants1):-1:2
    nrants1(i) = nrants1(i)-nrants1(i-1);
    nrants2(i) = nrants2(i)-nrants2(i-1);
    
end
plot(ti,nrants1,ti,nrants2);
sources(1)
sources(2)