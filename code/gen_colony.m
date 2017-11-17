function[colonies] = gen_colony()

% place, nrOfAnts, Ants
colonies = [];

colonies(1).pos = 1;
colonies(1).nrAnts = 10;
colonies(1).ants = [];

nrColonies = size(colonies,2)

for col=1:1:nrColonies

    for i=1:1:colonies(col).nrAnts
       colonies(col).ants(i) = gen_ant(col, colonies(col).pos); 
    end
    
end
