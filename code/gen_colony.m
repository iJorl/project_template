function[colonies] = gen_colony(nodes, antsPerColony)

% place, nrOfAnts, Ants

nrOfAnts = antsPerColony;

colonies = [];
s = 1;
n = length(nodes);
for i=1:n
    if strcmp(nodes(i).type,'colony') 
        colonies(s).pos = i;
        colonies(s).population = nrOfAnts;
        colonies(s).upperLimit = nrOfAnts * 2;
        colonies(s).lowerLimit = nrOfAnts * 0.5;
        s = s + 1;
    end
end


% nrColonies = size(colonies,2);
% 
% for col=1:1:nrColonies
% 
%     for i=1:1:colonies(col).nrAnts
%        %colonies(col).ants(i) 
%        colonies(col).ants(i) = gen_ant(col, colonies(col).pos);
%     end
%     
% end
