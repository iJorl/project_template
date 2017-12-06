function[colonies] = gen_colony(nodes)

% place, nrOfAnts, Ants

nrOfAnts = 1;

colonies = [];
s = 1;
n = length(nodes);
for i=1:n
    if nodes(i).type == "colony" 
        colonies(i).pos = i;
        colonies(i).nrAnts = nrOfAnts;
        s = s + 1;
    end
end


nrColonies = size(colonies,2);

for col=1:1:nrColonies

    for i=1:1:colonies(col).nrAnts
       %colonies(col).ants(i) 
       colonies(col).ants(i) = gen_ant(col, colonies(col).pos);
    end
    
end
