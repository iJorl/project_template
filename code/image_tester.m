%plot(1:3)
%hold on
%C = [1 2 3; 4 5 6; 7 8 9];
%im = image(C);
%im.AlphaData = 0.5;
I = imread('images/base.png');
RGB = insertShape(I,'circle',[150 280 35],'LineWidth',5);    

for i=1:1:10
    RGB = insertShape(I,'circle',[150+10*i 280 35],'LineWidth',5);    
    imshow(RGB)
end
imshow(RGB)
title('Original Grayscale Image', 'FontSize', 12);
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
% Give a name to the title bar.
set(gcf, 'Name', 'Demo by ImageAnalyst', 'NumberTitle', 'Off')
hold on;
axis on;
% Then, from the help:
rectangle('Position',[95,35,40,50],...
	'Curvature',[0.8,0.4],...
	'EdgeColor', 'r',...
	'LineWidth', 3,...
	'LineStyle','-')

viscircles([100,100],1, 'Color', 'g')
