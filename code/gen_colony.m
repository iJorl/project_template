function[cols, ants] = gen_colony()

% place, nrOfAnts, Ants
cols = [
    [1, 10]
];
ants = [
]

for i=1:1:cols(1,2)
    ants(i,:) = ant(1, cols(1,1))
    %x{1}(3)(i)=ant(1,x{1}(1));
    %x(1){3}(i)=ant(1,x(1));
end