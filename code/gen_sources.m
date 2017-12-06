
function[x] = gen_sources(nodes)

% assume an initial state where qualitiy is the same and no ants have
% visited

x = [];
s = 1;
n = length(nodes);
for i=1:n
    if nodes(i).type == "colony" 
        x(s).pos = i;
        x(s).quality = 1;
        x(s).antNr = 0;
        s = s + 1;
    end
end
