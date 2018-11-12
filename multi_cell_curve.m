%Bring in mask frames:
Frames_mask = 'D:\Mitch_temp\mask_nucleus\frame_0013.tif';
Frames_cell = 'D:\Mitch_temp\Frames_bcksub\frame_0004';
frame_check_mask = Frames_mask;
frame_check_cell = Frames_cell;
[folder,~,~] = fileparts(frame_check_mask);
[folder2,~,~] = fileparts(frame_check_cell);
Frames_mask=dir([folder '/*.tif']);
Frames_cell=dir([folder2 '/*.tif']);
out=size(Frames_mask,1);
out2=size(Frames_cell,1);

%Options for cell mask images:
scaling = 7;
Options.Verbose=true;
Options.nPoints = 300; %Number of contour points, default 100 %200 before
Options.Iterations=500; %Number of iterations, default 100 %500 before
Options.Wedge=2; %Attraction to edges, default 2.0 %was 2
Options.Wline=0; %Attraction to lines, if negative to black lines otherwise white, def .04 %0 before
Options.Wterm=0; %Attraction to terminations of lines (end points) and lines, def .01 %0 before
Options.Kappa=8; %Weight of external image force, default 2 %4 before
Options.Sigma1=8; %Sigma used to calculate image derivatives, default 10 %8 before
Options.Sigma2=15; %Gradient of the edge energy image (image force), def 20 %15 before
Options.Alpha=0.1; %Membrame energy  (first order), default 0.2 %.1 before
Options.Beta=0.1; %Thin plate energy (second order), default 0.2 %.1 before
Options.Mu=0.2; %Trade of between real edge vectors, and noise vectors, default 0.2.
Options.Delta=-0.1; %Baloon force, default 0.1
Options.GIterations=0; %Number of GVF iterations, default 0 %400 before

%{
%Make Curvature Video with Masks:
Curve_Video(out) = struct('cdata',[],'colormap',[]);
for i=1:out
    close all
    disp('Executing Snake Method Frame:')
    disp(i)
    set(0,'DefaultFigureVisible','off');
    first = {Frames_mask(i).folder};
    second = {Frames_mask(i).name};
    full = fullfile(first,second);
    strang = convertStringsToChars(string(full));
    [B,P] = binary_curves(strang,scaling);
    [Vertices,~]=Snake2D(B,P,Options);
    k = LineCurvature2D(Vertices);
    newvertsx = Vertices(:,2);
    newvertsy = Vertices(:,1);
    param = .02;
    set(0,'DefaultFigureVisible','on');
    gencolor_curves(newvertsx,newvertsy,k,param,B)
    Curve_Video(i) = getframe;
end
disp('Saving curvature videos to current Matlab directory path')
y = VideoWriter('Curve_Video_Cellstack.avi', 'Uncompressed AVI');
y.FrameRate = 20;
open(y)
writeVideo(y,Curve_Video)
close(y)
%}

%Make Curvature Video with Raw Cell Images:
Curve_Video(out2) = struct('cdata',[],'colormap',[]);
for i=1:out2
    close all
    disp('Executing Snake Method Frame:')
    disp(i)
    set(0,'DefaultFigureVisible','off');
    first_mask = {Frames_mask(i).folder};
    first_cell = {Frames_cell(i).folder};
    second_mask = {Frames_mask(i).name};
    second_cell = {Frames_cell(i).name};
    full_mask = fullfile(first_mask,second_mask);
    full_cell = fullfile(first_cell,second_cell);
    strang_mask = convertStringsToChars(string(full_mask));
    strang_cell = convertStringsToChars(string(full_cell));
    [B,P] = binary_curves(strang_mask,scaling);
    [Vertices,~]=Snake2D(B,P,Options);
    k = LineCurvature2D(Vertices);
    newvertsx = Vertices(:,2);
    newvertsy = Vertices(:,1);
    param = .02;
    set(0,'DefaultFigureVisible','on');
    
    gencolor_curves((newvertsx/7),(newvertsy/7),k,param,strang_cell)
    Curve_Video(i) = getframe;
end

disp('Saving curvature videos to current Matlab directory path')
y = VideoWriter('Curve_Video_Cellstack2.avi', 'Uncompressed AVI');
y.FrameRate = 20;
open(y)
writeVideo(y,Curve_Video)
close(y)
