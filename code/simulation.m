%SIMULATION.m
%--------------------------
function[] = simulation(graph, nodes, edges, sources,...
                        colonies, ants, ...
                        time, timestep, const_phermons, draw_properties)
%check all parameters
%--------------------------




%Simulation loop
%--------------------------
% for each timestep
%   for each colony
    % for each ant
    %   do ant_sim()

nrColonies = length(colonies);

colonyProd = [];
for i=1:1:nrColonies
    colonyProd(i).foodCounter       = 0;
    colonyProd(i).foodCounterGlobal = 0;
    colonyProd(i).intervals         = [0];
    colonyProd(i).interval          = 2;
end
for t=1:timestep:time
    % move ants
    for antI=1:1:length(ants)
        [ants(antI),sources,edges, prod]= ant_move(ants(antI), sources, nodes, edges, colonies);
        colonyProd(ants(antI).colony).foodCounter = colonyProd(ants(antI).colony).foodCounter + prod;
    end

    %update phermeons
    for p=1:1:length(edges)
        for cc=1:1:length(colonies)
            edges(p).phermons(cc) = edges(p).phermons(cc) * (1 - 1/const_phermons);
        end
    end
    %measure productivity over smaller intervalls
    if mod(t,50) == 0
        for i=1:1:nrColonies
                % add a new entry
                colonyProd(i).intervals(colonyProd(i).interval) = colonyProd(i).foodCounter;
                colonyPord(i).foodCounterGlobal = colonyProd(i).foodCounterGlobal + colonyProd(i).foodCounter;
                colonyProd(i).foodCounter = 0;
                colonyProd(i).interval = colonyProd(i).interval + 1;
        end
    end
    
    
    %Visualize Simulation
    if draw_properties.draw == 1 && mod(t,draw_properties.timestep) == 0
        draw(nodes,edges, colonies, ants, draw_properties);
    end
       
end
for i=1:1:length(ants)
   ants(i) 
end
%colonies(1).ants(7).path
hold on
for i=1:1:length(colonyProd)
    colonyProd(i).intervals
    plot([1:1:length(colonyProd(i).intervals)],colonyProd(i).intervals)
end
hold off
saveas(gcf,strcat('exports/plot_' ,strcat('1','.png')));

figure()
draw(nodes,edges, colonies, ants, draw_properties);