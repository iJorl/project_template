function[newAnt,newSources,newEdges] = ant_move(ant, sources, nodes, edges)

uturnProb = 0.1; % Probability of a u-turn if no pheromones on edge

%First time the ant is moved
if ant.edge == 0
    %select edge
    ant.edge = ant_decision(ant, nodes, edges);
    ant.edgeProgress = edges(ant.edge).weight;
    % determine if direction is - or +
    if edges(ant.edge).from == ant.pos
        ant.direction = 1;
    else
        ant.direction = -1;
    end
end

% explore graph
if strcmp(ant.state,'explore')
    % on a node
    if ant.edgeProgress == 0
        % add new node to the path
        if ant.direction == 1
            nextEdge = edges(ant.edge).to;
        else
            nextEdge = edges(ant.edge).from;
        end
        if ant.pos ~= nextEdge
            ant.path(length(ant.path)+1) = nextEdge;
        end
        
        ant.pos = ant.path(length(ant.path));
        % check if discovered food source! - if yes has to switch to back
        if strcmp(nodes(ant.pos).type,'source')
            ant.state = 'back';
            ant.direction = ant.direction*(-1);
            ant.edgeProgress = edges(ant.edge).weight;
            % Adjust quality of the carried food & invrement counter of
            % source
            pos = ant.pos;%ant.path(length(ant.path));
            
            ant.food = sources(nodes(pos).link).quality;
            sources(nodes(pos).link).antNr = sources(nodes(pos).link).antNr + 1;
            
            %for i=1:length(sources)
            %    if sources(i).pos == pos
            %        ant.food = sources(i).quality;
            %        sources(i).antNr = sources(i).antNr+1;
            %    end
            %end
            edges(ant.edge).phermons(ant.colony) = edges(ant.edge).phermons(ant.colony)+ant.food;
            ant.path = ant.path(1:end-1);
        end
        % TODO: change in phase 3!!
        if (strcmp(nodes(ant.pos).type,'traffic') || strcmp(nodes(ant.pos).type,'colony'))
            %select new edge
            nextEdge = ant_decision(ant, nodes, edges);
            back = 0;
            % Stuck in a cycle
            while nextEdge == -1
                back = back+1;
                ant.pos = ant.path(length(ant.path)-back);
                nextEdge = ant_decision(ant, nodes, edges);
            end
            ant.path = ant.path(1:end-back);
            
            ant.edge = nextEdge;
            ant.edgeProgress = edges(nextEdge).weight;
            % determine if direction is - or +
            if edges(nextEdge).from == ant.pos
                ant.direction = 1;
            else
                ant.direction = -1;
            end
        end
    
        % Walk forward on the new edge;
        ant.edgeProgress = ant.edgeProgress -1;
           
    else
    % travelling on a edge
        % make a uturn? phermons on edge / phermons on all edges at prev.
        % node
        denum = 0;
        for i=1:length(nodes(ant.pos).edges)
            denum = denum + edges(nodes(ant.pos).edges(i)).phermons(ant.colony);
        end
        r = rand;
        if denum~=0 && (1-(edges(ant.edge).phermons(ant.colony)/denum))*uturnProb>r
            % only turn if this is the first Uturn on the edge
            if (ant.direction == 1 && edges(ant.edge).from == ant.pos) ||(ant.direction == -1 && edges(ant.edge).to == ant.pos)
                %only turn if already moved
                if edges(ant.edge).weight - ant.edgeProgress>0
                    ant.direction = ant.direction *(-1);
                    ant.edgeProgress = edges(ant.edge).weight - ant.edgeProgress;
                end
            end
        end
        % move ant
        ant.edgeProgress = ant.edgeProgress-1;     
    end

% back to colony nest
else
    % on a node
    if ant.edgeProgress == 0
        ant.pos = ant.path(length(ant.path));
        ant.path = ant.path(1:end-1);
        % back at home -> turn around 
        if isempty(ant.path)
            ant.path(1) = ant.pos;
            ant.state = 'explore';
            ant.edge = ant_decision(ant, nodes, edges);
            ant.edgeProgress = edges(ant.edge).weight;
            ant.food = 0;
            if edges(ant.edge).from == ant.pos
                ant.direction = 1;
            else
                ant.direction = -1;
            end
        % on a traffic node
        else
            % find next edge
            for i=1:length(nodes(ant.pos).edges)
                e = nodes(ant.pos).edges(i);
                if edges(e).from == ant.path(length(ant.path)) || edges(e).to == ant.path(length(ant.path))
                   ant.edge = e;
                end
            end
            ant.edgeProgress = edges(ant.edge).weight;
            if edges(ant.edge).from == ant.pos
                ant.direction = 1;
            else
                ant.direction = -1;
            end
        end
        ant.edgeProgress = ant.edgeProgress -1;  
        edges(ant.edge).phermons(ant.colony) = edges(ant.edge).phermons(ant.colony) + ant.food;
    else

        % travelling on a edge
        ant.edgeProgress = ant.edgeProgress-1;
        % place phermons 
        edges(ant.edge).phermons(ant.colony) = edges(ant.edge).phermons(ant.colony) + ant.food;
    end
end

newAnt = ant;
newEdges = edges;
newSources = sources;