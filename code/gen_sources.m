
function[x] = gen_sources()

% where located, food quality, #ants

x(1).pos = 2;           % Index of the node in graph
x(1).quality = 10;      % Quality of the food source
x(1).anrNr = 0;         % Number of ants at the sources

x(2).pos = 3;           % Index of the node in graph
x(2).quality = 10;      % Quality of the food source
x(2).antNr = 0;         % Number of ants at the sources

%x = [
%    [2, 10, 0];
%    [3, 10, 0]
%];