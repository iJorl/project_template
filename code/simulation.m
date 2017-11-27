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
nrants1 = [];
nrants2 = [];
ti = [1:timestep:time/5];

pher1 = []
pher2 = []

for t=1:timestep:time
    for col=1:1:nrColonies
        % move ants
        for antI=1:1:colonies(col).nrAnts
           [colonies(col).ants(antI),sources,edges] = ant_move(colonies(col).ants(antI), sources, nodes, edges);
        end
       if(mod(t,5) == 0)
            nrants1(t/5) = sources(1).antNr;
            nrants2(t/5) = sources(2).antNr;
       
            pher1(t/5) = edges(2).phermons;
            pher2(t/5) = edges(3).phermons;
       end
       %update phermeons
       for p=1:1:length(edges)
           edges(p).phermons = edges(p).phermons * (1 - 1/const_phermons);
       end
       
        
    end
end
% return results
%--------------------------
for i=length(nrants1):-1:2
    nrants1(i) = nrants1(i)-nrants1(i-1);
    nrants2(i) = nrants2(i)-nrants2(i-1);
    
end
plot(ti,nrants1,'b',ti,nrants2, 'r');
g = figure();
plot(ti,pher1, 'b', ti, pher2, 'r');
sources(1)
sources(2)