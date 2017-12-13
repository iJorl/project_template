function[edge] = ant_decision(ant, nodes, edges)

n = 2;          % Non-linearity factor
k = 6;          % attractivity of a unmarked path

prob = [];
forbidden = [];
% Formula for the probability : p(i) = (k+ci)^n/(k+c_1)^n+....+(k+c_m)^n

denumerator = 0;

%cycle prevention
for i=1:length(nodes(ant.pos).edges)
    curr = nodes(ant.pos).edges(i);

%     %prevent circles
%     if ant.direction == 0
%         check = 0;
%     else
%         if edges(curr).to ~= ant.pos
%             check = edges(curr).to;
%         else
%             check = edges(curr).from;
%         end
%     end
    found = 0;
    
    %Prevent ant from going back on the edge they came from
    if curr == ant.edge
       found = 1;
       forbidden(length(forbidden)+1) = i;
    end
%     for j=1:length(ant.path)
%         if check == ant.path(j)
%             found = 1;
%             forbidden(length(forbidden)+1) = i;
%         end
%     end
     if found == 0
         denumerator = denumerator + ((edges(curr).phermons(ant.colony)/edges(curr).weight)+k)^n;
     end
end 



for i=1:length(nodes(ant.pos).edges)                % Calculate the probability of every edge
    curr = nodes(ant.pos).edges(i);
    prob(i) = (k+(edges(curr).phermons(ant.colony)/edges(curr).weight))^n/denumerator;
end

%prevent loops
for i=1:length(forbidden)
    prob(forbidden(i)) = 0;
end

r = rand();

%return -1 if no edge could be found (one way street)
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