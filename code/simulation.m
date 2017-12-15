%SIMULATION.m
%--------------------------
function[] = simulation(graph, nodes, edges, sources,...
                        colonies, ants, ...
                        time, timestep, timeInterval, const_phermons, draw_properties, strategy)
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

globalProd.intervals = [0];

for i=1:1:nrColonies
    colonyProd(i).foodCounter       = 0;
    colonyProd(i).foodCounterGlobal = 0;
    colonyProd(i).intervals         = [0];
    colonyProd(i).interval          = 2;
    colonyProd(i).populationInterval = [colonies(i).population, 0];
end
sourceProd = [];
for i=1:1:nrSources
    sourceProd(i).antsCount = 0;
    sourceProd(i).intervals         = [0];
    sourceProd(i).interval          = 2;
end
    
progressPer = 0;
for t=1:timestep:time
    %show progress
    if ceil(t/time*100) > progressPer
       progressPer = ceil(t/time*100) 
    end
    % move ants
   for antI=1:1:length(ants)
   %for antI=1:1:1 %ONLY TESTING PURPOSES
        [ants(antI),sources,edges, prod, PopChange]= ant_move(ants(antI), sources, nodes, edges, colonies, colonyProd, strategy, globalProd);
        colonyProd(ants(antI).colony).foodCounter = colonyProd(ants(antI).colony).foodCounter + prod;
        if PopChange(1) ~= 0
           colonies(PopChange(1)).population = colonies(PopChange(1)).population + 1;
           colonies(PopChange(2)).population = colonies(PopChange(2)).population -1;
        end
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
    
    % count ants in colonies
    for i=1:1:nrColonies
       colonyProd(i).populationInterval(colonyProd(i).interval) = colonyProd(i).populationInterval(colonyProd(i).interval) + colonies(i).population; 
    end
    
    %measure productivity over smaller intervalls
    if mod(t,timeInterval) == 0
        s = 0;
        for i=1:1:nrColonies
                % add a new entry
                colonyProd(i).populationInterval(colonyProd(i).interval) = colonyProd(i).populationInterval(colonyProd(i).interval)/ timeInterval;
                
                colonyProd(i).intervals(colonyProd(i).interval) = colonyProd(i).foodCounter / colonyProd(i).populationInterval(colonyProd(i).interval);
                colonyPord(i).foodCounterGlobal = colonyProd(i).foodCounterGlobal + colonyProd(i).foodCounter;
                colonyProd(i).foodCounter = 0;
                colonyProd(i).interval = colonyProd(i).interval + 1;
                
                colonyProd(i).populationInterval(colonyProd(i).interval) = 0;
                
                s = s + colonyProd(i).intervals(end);
        end
        globalProd.intervals(end+1) = s;
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
analyse(colonyProd, sourceProd, globalProd)


draw(nodes,edges, colonies, ants, draw_properties);