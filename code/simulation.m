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
nrSources  = length(sources);

colonyProd = [];
for i=1:1:nrColonies
    colonyProd(i).foodCounter       = 0;
    colonyProd(i).foodCounterGlobal = 0;
    colonyProd(i).intervals         = [0];
    colonyProd(i).interval          = 2;
end
sourceProd = [];
for i=1:1:nrSources
    sourceProd(i).antsCount = 0;
    sourceProd(i).intervals         = [0];
    sourceProd(i).interval          = 2;
end
    
for t=1:timestep:time
    % move ants
   for antI=1:1:length(ants)
   %for antI=1:1:1 %ONLY TESTING PURPOSES
        [ants(antI),sources,edges, prod]= ant_move(ants(antI), sources, nodes, edges, colonies);
        colonyProd(ants(antI).colony).foodCounter = colonyProd(ants(antI).colony).foodCounter + prod;
    end
    
    %pause;
    %refill sources
    for s=1:1:length(sources)
       sources(s).food = min(sources(s).food + sources(s).increase, sources(s).maxFood); 
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
        for i=1:1:nrSources
                % add a new entry
                sourceProd(i).intervals(sourceProd(i).interval) = sources(i).antNr - sourceProd(i).antsCount;
                sourceProd(i).antsCount = sources(i).antNr;
                sourceProd(i).interval = sourceProd(i).interval + 1;
        end
    end
    
    
    %Visualize Simulation
    if draw_properties.draw == 1 && mod(t,draw_properties.timestep) == 0
       % draw(nodes,edges, colonies, ants, draw_properties);
    end
       
end

%colonies(1).ants(7).path

%analyze script
analyse(colonyProd, sourceProd)


draw(nodes,edges, colonies, ants, draw_properties);