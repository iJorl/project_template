function[ant] = ant_gen(colonyNr,pos)

% pos,state,colony,food,edge,edgeProgress,path
% state: 0 to source, 1 to nest
% food: quality of food
ant.pos = pos;                  % position in graph
ant.state = 'explore';          % explore = to food source, back = back to nest
ant.colony  = colonyNr;         % Nr of colony
ant.food = 0;                   % Quality of food carrying (0 = no food)
ant.edge = 0;                   % Index of curr edge
ant.edgeProgress = 0;           % Progress on edge
ant.path = [0];                 % Path the ant took so far


%ant = [pos,0,colonyNr,0,0,0,-1];