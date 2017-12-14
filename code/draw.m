function [] = draw(nodes, edges, colonies,ants, draw_properties)
% set constants
n=length(nodes);
m = length(edges);
cols = length(colonies);
nrAnts = length(ants);


for col=1:1:cols
    %set settings
    clf('reset');
    if(draw_properties.show == 0)
        set(gcf, 'Visible', 'off');
    end
    title(strcat('Matlab Visualization of Colony ',num2str(col)), 'FontSize', 12);
    % Enlarge figure to full screen.
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    % Give a name to the title bar.
    set(gcf, 'Name', 'Viz by Mantlab', 'NumberTitle', 'Off')
    set(gca,'Ydir','normal');
    hold on;
    axis on;

    % find right scale
    mi = 1000;
    ma = 0;
    height = 1000;
    width = 1000;
    for i=1:1:n
        mi = min(mi, min(nodes(i).pos(1), nodes(i).pos(2)));
        ma = max(ma, max(nodes(i).pos(1), nodes(i).pos(2)));
    end

    dist = ma-mi;
    dist = dist*1.4;
    per = 1000/dist;
    off = 0.2*dist;

    %draw Edges

    maxPherPerEdge = 0;
    for i=1:1:m
       maxPherPerEdge = max(maxPherPerEdge,edges(i).phermons(col)/edges(i).weight); 
    end

    for i=1:1:m
        a = edges(i).to;
        b = edges(i).from;
        pp = (edges(i).phermons(col) / edges(i).weight) /maxPherPerEdge;
        lw = 1 + 7*pp;
        if isnan(lw)
           lw = 1; 
        end
        ax = (off + nodes(a).pos(1)*per);
        ay = (off + nodes(a).pos(2)*per);
        bx = (off + nodes(b).pos(1)*per);
        by = (off + nodes(b).pos(2)*per);
       line([ax bx], [ ay by ],...
       'Color', 'k','Linewidth', lw);
    end

    %draw nodes
    for i=1:1:n
        viscircles([off + nodes(i).pos(1)*per,off + nodes(i).pos(2)*per], ...
            3, 'Color', 'r');
    end

    %draw the ants
    if draw_properties.showAnts == 1
        for antI=1:1:nrAnts
            if ants(antI).colony ~= col
               continue; 
            end
            posA = ants(antI).pos;
            edge = ants(antI).edge;
            posB = posA;
            if edge ~= 0
                posB = edges(edge).from;
                if posA == posB || posB < 0
                    posB = edges(edge).to; 
                end
            end

            dirX = nodes(posB).pos(1)-nodes(posA).pos(1);
            dirY = nodes(posB).pos(2)-nodes(posA).pos(2);

            progp = 0;
            if edge ~= 0
                prog = ants(antI).edgeProgress;
                prog = edges(edge).weight - prog;
                progp = prog / edges(edge).weight;
            end

            posX = nodes(posA).pos(1) + progp*dirX; 
            posY = nodes(posA).pos(2) + progp*dirY;

            viscircles([off + posX*per,off + posY*per], ...
            2, 'Color', 'b');
        end
    end
    prefix =strcat( strcat('col_',num2str(col)), strcat('time_',num2str(draw_properties.frameNr)));
    saveas(gcf,strcat('exports/graph_' ,strcat(prefix,'.png')));
end
draw_properties.frameNr = draw_properties.frameNr + 1;
