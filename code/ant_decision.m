function[edge] = ant_decision(ant, nodes, edges)

n = 2;          % Non-linearity factor
k = 6;          % attractivity of a unmarked path

prob = [];

% Formula for the probability : p(i) = (k+ci)^n/(k+c_1)^n+....+(k+c_m)^n

denumerator = 0;
for i=1:length(nodes(ant.pos).edges)
    curr = nodes(ant.pos).edges(i);
    denumerator = denumerator + (edges(curr).phermons+k)^2;
end 

if(strcmp(nodes(ant.pos).type,'traffic'))                % at Source and Colony nodes all the directions can be chosen, at traffic nodes a u-turn is not allowed
    denumerator = denumerator - (edges(ant.edge).phermons+k)^2;
end

for i=1:length(nodes(ant.pos).edges)                % Calculate the probability of every edge
    prob(i) = ((k+edges(i).phermons)^2)/denumerator;
    if(nodes(ant.pos).edges(i) == ant.edge)         % This probability has to be removed for traffic nodes (U-Turn)    
        curr = i;
    end
end

if(strcmp(nodes(ant.pos).type,'traffic'))             
    prob(curr) = 0;
end

r = rand();

edge = -1;

for i=2:length(prob)
    prob(i) = prob(i)+prob(i-1);
end

for i=1:length(prob)
    if r<=prob(i) && edge < 0
        edge = nodes(ant.pos).edges(i);
    end
end