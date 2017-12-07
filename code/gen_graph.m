function[graph, nodes, edges] = gen_graph()

%open file
fileID = fopen('graphs/phase_2.txt','r');
filter = '%f %f';
A = fscanf(fileID, filter);
fclose(fileID);

% GEN_GRAPH
%---------------------------------------

n = A(1); m = A(2);
% graph stores index of adj. edges


%graph = {[1];[1, 2, 3];[2];[3]};
graph  = {};
% access with graph{nodeNr}(edgeNr)

%edge stores begin, end, weight, phermons
edges = [];
offset = 2;
for i=1:1:m
    edges(i).from     = A(offset + 1);
    edges(i).to       = A(offset + 2);
    edges(i).weight   = A(offset + 3);
    edges(i).phermons = 0;   
    offset = offset + 3;
end

nodes = [];
for i=1:1:n
    % determine type
    nodes(i).type= 'traffic';
    if A(offset + 2) == 1
       nodes(i).type = 'colony'; 
    end
    if A(offset + 2) == 2
        nodes(i).type = 'source';
    end
    
    % link to correct source or nest
    nodes(i).link = A(offset+3);
    
    % get all edges
    nodes(i).edges = [];
    s = 1;
    for j=1:1:m
        if edges(j).from == i
            nodes(i).edges(s) = edges(j).to;
            s = s+1;
        end
        if edges(j).to == i
            nodes(i).edges(s) = edges(j).from;
            s = s+1;
        end
    end
    
    offset = offset + 3;
end

% node stores: type, link, edges
% type 1 = colony, type 2 = food, type 0 = traffic node
