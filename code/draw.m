function [] = draw(nodes, edges)

n=length(nodes)

I = imread('images/base.png');
%RGB = insertShape(I,'circle',[150 280 35],'LineWidth',5);
imshow(RGB)
title('Original Grayscale Image', 'FontSize', 12);
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
% Give a name to the title bar.
set(gcf, 'Name', 'Demo by ImageAnalyst', 'NumberTitle', 'Off')
set(gca,'Ydir','normal');
hold on;
axis on;

% find right scale

mi = 1000;
ma = 0;
[height, width] = size(I);
for i=1:1:n
    mi = min(mi, min(nodes(i).pos(1), nodes(i).pos(2)));
    ma = max(ma, max(nodes(i).pos(1), nodes(i).pos(2)));
end


dist = ma-mi;
dist = dist*1.4;
per = 1000/dist;
for i=1:1:n
    viscircles([0.2*dist + nodes(i).pos(1)*per,0.2*dist + nodes(i).pos(2)*per],1, 'Color', 'g')
end

for i=1:1:m
    
end
