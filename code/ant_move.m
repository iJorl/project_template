function[newAnt,newSources,newEdges, prod, popChange] = ant_move(ant, sources, nodes, edges, colonies, colonyProd, strategy, globalProd)

prod = 0;
popChange = [0,0];
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

%Recover from a dead end
if strcmp(ant.state,'deadEnd')
    if ant.edgeProgress == 0
       % ant
        ant.pos = ant.path(length(ant.path));
        ant.path = ant.path(1:end-1);
        % Walk back until a node with degree > 2 is found
        if length(nodes(ant.pos).edges)>2 || length(ant.path) == 0
            %ant.path = ant.path(1:end-1);
            ant.state = 'explore';
            if(length(ant.path))~=0
                ant.pos = ant.path(end);
            end
        else
            %ant.pos = ant.path(length(ant.path));
            %ant.path = ant.path(1:end-1);
            if nodes(ant.pos).edges(1) ~= ant.edge
                ant.edge = nodes(ant.pos).edges(1);
            else
                ant.edge = nodes(ant.pos).edges(2);
            end
            %Adjust direction
            if edges(ant.edge).from == ant.pos
                ant.direction = 1;
            else
                ant.direction = -1;
            end
            ant.edgeProgress = edges(ant.edge).weight-1;
        end
    else
        ant.edgeProgress = ant.edgeProgress -1;
    end
end

% explore graph
if strcmp(ant.state,'explore')
    % on a node
    if ant.edgeProgress == 0
        % check 
        % add new node to the path
        if ant.direction == 1
            nextPos = edges(ant.edge).to;
        else
            nextPos = edges(ant.edge).from;
        end
        
        % if the added node leads to a cycle then remove the cycle in path
        cycStart = -1;
        for i=1:length(ant.path)
            if ant.path(i) == nextPos && cycStart<0
                cycStart = i;
            end
        end
        %if the ant goes back to its own colony thats a deadend, not a
        %cycle!
        if cycStart>0 && length(nodes(nextPos).edges)>1
            'CYCLE!!!!!';
            ant.path = ant.path(1:cycStart-1);
        end
        %Add new node to path
        if ant.pos ~= nextPos
            %ant.path(length(ant.path)+1) = nextPos;
        end
        
        ant.path(length(ant.path)+1) = nextPos;
        
        ant.pos = ant.path(length(ant.path));
        % check if discovered food source! - if yes has to switch to back
        % cant be own colony!
        if strcmp(nodes(ant.pos).type,'source') && ant.pos ~= colonies(ant.colony).pos %&& sources(nodes(ant.pos).link).food > 0
            %maybe want to apply local strategy
            changedFlag = 0;
            if strcmp(strategy.type, 'local')
                colNr1 = ant.colony;
                colNr2 = 0;
                for i=1:1:length(colonies)
                   if colonies(i).pos == ant.pos
                      colNr2 = i;
                      break;
                   end
                end
                % is actually a colony
                if colNr2 ~= 0
                    % check if change even allowed
                    if(colonies(colNr1).population > colonies(colNr1).lowerLimit && colonies(colNr2).population < colonies(colNr2).upperLimit)
                        p1 = colonyProd(colNr1).intervals(end); p2 = colonyProd(colNr2).intervals(end);
                        diff = p2-p1;
                        % colony2prod is higher than mine
                        if diff > 0
                           r = rand();
                           if r <= (diff)/(p1+p2) %swap with prob (diff/ total)
                               'CHANGE';
                               ant = gen_ant(colNr2, ant.pos);
                               colonies(colNr2).population = colonies(colNr2).population + 1;
                               colonies(colNr1).population = colonies(colNr1).population - 1;
                               popChange = [colNr2, colNr1];
                               changedFlag = 1;
                           end
                        end
                    end
                     
                end
                   
            end
            
            
            %if switched source no need for further code
            if changedFlag == 0
            
                ant.state = 'back';
                ant.direction = ant.direction*(-1);
                ant.edgeProgress = edges(ant.edge).weight;
                % Adjust quality of the carried food & invrement counter of
                % source
                pos = ant.pos;%ant.path(length(ant.path));

                %ant.food = sources(nodes(pos).link).quality;
                if(sources(nodes(pos).link).food > 0)
                    ant.food = min(sources(nodes(pos).link).food,1) * sources(nodes(pos).link).quality;
                    sources(nodes(pos).link).food = sources(nodes(pos).link).food -1;
                else
                    ant.food = 0;
                end
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
        elseif (strcmp(nodes(ant.pos).type,'traffic') || strcmp(nodes(ant.pos).type,'colony') || (strcmp(nodes(ant.pos).type,'source') && ant.pos == colonies(ant.colony).pos))
            %select new edge
            %ant
            nextEdge = ant_decision(ant, nodes, edges);

            % Ant walked in to a dead end (traffic node with degree 1) ->
            % walk back on edge
            if nextEdge == -1
               'DEADEND!!!!';
               ant.state = 'deadEnd';
               ant.path = ant.path(1:end-1);
               nextEdge = ant.edge;
               % ant.pos = ant.path(end);
            end
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
end
if strcmp(ant.state,'back')
    % on a node
    if ant.edgeProgress == 0
        ant.pos = ant.path(length(ant.path));
        ant.path = ant.path(1:end-1);
        
        relocate = 0;
        % back at home -> turn around 
        if isempty(ant.path)
            %relocate = 1;

            % decide to relocate
            if strcmp(strategy.type, 'global') == 1
                a = colonyProd(ant.colony).intervals(end); 
                b = globalProd.intervals(end)/length(colonies);
                if a < b
                   r = rand();
                   p = (b-a)/(a+b);
                   if r <= p
                      relocate = 1; 
                   end
                end
            end
            
            prod = ant.food;
            ant.path(1) = ant.pos;
            ant.edge = 0;
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
        if relocate == 0
            ant.edgeProgress = ant.edgeProgress -1;  
            edges(ant.edge).phermons(ant.colony) = edges(ant.edge).phermons(ant.colony) + ant.food;
        elseif colonies(ant.colony).population > colonies(ant.colony).lowerLimit
            %relocate
                       
            colNr = 0;
            % calc prob where to move
            
            avgProd = globalProd.intervals(end)/length(colonies);
            ps = 0;
            for i=1:1:length(colonies)
                %check if desirable target
                if( avgProd <= colonyProd(i).intervals(end) ) 
                   % check if still moving space
                   if(colonies(i).population < colonies(i).upperLimit)
                        ps = ps + colonyProd(i).intervals(end);
                   end
                end
            end
            r = rand() * ps;
            for i=1:1:length(colonies)
                %check if desirable target
                if( avgProd <= colonyProd(i).intervals(end) ) 
                   % check if still moving space
                   if(colonies(i).population < colonies(i).upperLimit)
                        ps = ps - colonyProd(i).intervals(end);
                        if(ps <= 0)
                           colNr = i; 
                           break;
                        end
                   end
                end
            end
            
            % create new ant
            if(colNr ~= 0)
                popChange = [colNr, ant.colony];
                ant = gen_ant(colNr, colonies(colNr).pos);
            end
        end
    else

        % travelling on a edge
        ant.edgeProgress = ant.edgeProgress-1;
        % place phermons 
        edges(ant.edge).phermons(ant.colony) = edges(ant.edge).phermons(ant.colony) + ant.food;
    end
end

%ant

newAnt = ant;
newEdges = edges;
newSources = sources;