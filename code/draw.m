function [] = draw(nodes, edges, colonies)

n=length(nodes);

%I = imread('images/base.png');
%RGB = insertShape(I,'circle',[150 280 35],'LineWidth',5);
%imshow(RGB)
clf('reset');
title('Matlab Visualization of Ant Paths', 'FontSize', 12);
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
m = length(edges);

maxPherPerEdge = 0;
for i=1:1:m
   maxPherPerEdge = max(maxPherPerEdge,edges(i).phermons/edges(i).weight); 
end

for i=1:1:m
    a = edges(i).to;
    b = edges(i).from;
    pp = (edges(i).phermons / edges(i).weight) /maxPherPerEdge;
    lw = 1 + 7*pp;
   line([(off + nodes(a).pos(1)*per) (off + nodes(b).pos(1)*per)], ...
       [[ (off + nodes(a).pos(2)*per) (off + nodes(b).pos(2)*per)]],...
   'Color', 'k','Linewidth', lw);
end

%draw nodes
for i=1:1:n
    viscircles([off + nodes(i).pos(1)*per,off + nodes(i).pos(2)*per], ...
        3, 'Color', 'r');
    %line([100 100],[200 200])
    %line([50 100], [30 70], 'Linewidth', 10)
end

%draw the ants
cols = length(colonies);
for col=1:1:cols
    for antI=1:1:colonies(col).nrAnts
        posA = colonies(col).ants(antI).pos;
        edge = colonies(col).ants(antI).edge;
        posB = edges(edge).from;
        if posA == posB || posB < 0
           posB = edges(edge).to; 
        end
        dirX = nodes(posB).pos(1)-nodes(posA).pos(1);
        dirY = nodes(posB).pos(2)-nodes(posA).pos(2);
        prog = colonies(col).ants(antI).edgeProgress;
        prog = edges(edge).weight - prog;
        progp = prog / edges(edge).weight;
        
        dir = colonies(col).ants(antI).direction;
        
        posX = nodes(posA).pos(1) + progp*dirX; 
        posY = nodes(posA).pos(2) + progp*dirY;

        viscircles([off + posX*per,off + posY*per], ...
        2, 'Color', 'b');
        %viscircles([off + nodes(posA).pos(1)*per,off + nodes(posA).pos(2)*per], ...
        %3, 'Color', 'g')
        %viscircles([off + nodes(posB).pos(1)*per,off + nodes(posB).pos(2)*per], ...
        %3, 'Color', 'g')
        %[colonies(col).ants(antI),sources,edges] = ant_move(colonies(col).ants(antI), sources, nodes, edges);
    end
end

saveas(gcf,'exports/graph.png')