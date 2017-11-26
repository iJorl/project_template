function[edge] = ant_decision(ant, nodes, edges)

n = 2;          % Non-linearity factor
k = 6;          % attractivity of a unmarked path

prob = [];
forbidden = [];
% Formula for the probability : p(i) = (k+ci)^n/(k+c_1)^n+....+(k+c_m)^n

denumerator = 0;
for i=1:length(nodes(ant.pos).edges)
    curr = nodes(ant.pos).edges(i);
    
    %prevent circles
    if ant.direction == 0
        check = 0;
    else
        if ant.direction == 1
            check = edges(curr).to;
        else
            check = edges(curr).from;
        end
    end
    found = 0;
        for j=1:length(ant.path)
            if check == ant.path(j) && curr ~= ant.edge
                found = 1;
                forbidden(length(forbidden)+1) = i;
            end
        end
    if found == 0
        denumerator = denumerator + ((edges(curr).phermons/edges(curr).weight)+k)^2;
    end
end 

if(strcmp(nodes(ant.pos).type,'traffic'))                % at Source and Colony nodes all the directions can be chosen, at traffic nodes a u-turn is not allowed
    denumerator = denumerator - ((edges(ant.edge).phermons/edges(ant.edge).weight)+k)^2;
end

for i=1:length(nodes(ant.pos).edges)                % Calculate the probability of every edge
    prob(i) = (k+(edges(i).phermons/edges(i).weight))^2/denumerator;
    if(nodes(ant.pos).edges(i) == ant.edge)         % This probability has to be removed for traffic nodes (U-Turn)    
        curr = i;
    end
end

if(strcmp(nodes(ant.pos).type,'traffic'))             
    prob(curr) = 0;
end

%prevent loops
for i=1:length(forbidden)
    prob(forbidden(i)) = 0;
end

r = rand();

edge = -1;


for i=2:length(prob)
    prob(i) = prob(i)+prob(i-1);
end

%select one of the available edges by chance
for i=1:length(prob)
    if r<=prob(i) && edge < 0
        edge = nodes(ant.pos).edges(i);
    end
end

% if no edge was found because of a u-turn
if edge == -1
    edge = ant.edge;
end