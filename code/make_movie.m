function[] = make_movie(NR)

workingDir = 'video';
%shuttleVideo = VideoReader('shuttle.avi');

outputVideo = VideoWriter(fullfile(workingDir,'graph.avi'));
outputVideo.FrameRate = 2;%shuttleVideo.FrameRate;
open(outputVideo)

for ii = 0:1:NR
   %img = imread(strcat('exports/graph_', strcat(num2str(ii),'.png')))
   s = strcat('graph_', strcat(num2str(ii),'.png'));
   img = imread(fullfile('exports',s));
   writeVideo(outputVideo,img)
end

close(outputVideo)
