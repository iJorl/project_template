function[ant] = ant(colonyNr,pos)

% pos,state,colony,food,edge,edgeProgress,path
% state: 0 to source, 1 to nest
% food: quality of food
ant = [pos,0,colonyNr,0,0,0,-1];