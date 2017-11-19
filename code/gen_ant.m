function[ant] = gen_ant(colonyNr,pos)

% pos,state,colony,food,edge,edgeProgress,path
% state: 0 to source, 1 to nest
% food: quality of food
ant(1).pos = pos;                  % position in graph
ant(1).state = 'explore';          % explore = to food source, back = back to nest
ant(1).colony  = colonyNr;         % Nr of colony
ant(1).food = 0;                   % Quality of food carrying (0 = no food)
ant(1).edge = 0;                   % Index of curr edge
ant(1).edgeProgress = 0;           % Progress on edge
ant(1).path = [0];                 % Path the ant took so far
ant(1).direction = 0;              % Direction on the edge 


%ant = [pos,0,colonyNr,0,0,0,-1];