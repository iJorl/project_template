function[ants] = gen_ants(colonies)

totalAnts = 0;

for i=1:length(colonies)
    for j=1:colonies(i).population
        ants(totalAnts+1) = gen_ant(i, colonies(i).pos);
        totalAnts = totalAnts + 1;
    end
end