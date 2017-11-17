function[newAnt] = ant_move(ant, graph, sources, nodes, edges)

% explore graph
if ant.state == 'explore'

    % on a node
    if ant.edgeProgress == 0
        % check if discovered food source! - if yes has to switch to back
        if 
        
        
        %select new edge
        nextEdge = ant_decision(ant, graph, edges);
        ant.edge = nextEdge;
        
        % determine if direction is - or +
        if edges(nextEdge).from == ant.pos
            ant.direction = 1;
        else
            ant.direction = -1;
        end
    
        %could be that chosen edge is only length 1
    
        if edges(newEdge).weight == 1:
            ant.edgeProgress = 0;
        else
            ant.edgeProgress = 1; 
        end
        
    else
    % travelling on a edge
        % make a uturn?
        diffDir = 1;
        
        ant.edgeProgress = ant.edgeProgress + diffDir;
        
        %at end of edge?
        if ant.edgeProgress == edges(ant.edge).weight
           ant.edgeProgress = 0; 
           %update new position
           if ant.direction == 1
              ant.position = edges(ant.edge).to; 
           else
               ant.position = edges(ant.edge).from;
           end
        end
        
    end

% back to colony nest
else
    if ant.edgeProgress == 0
    % on a node
    
    else
    % travelling on a edge
        %make a uturn
        diffDir = 1;
        ant.edgeProgress += diffDir;
    end
end

