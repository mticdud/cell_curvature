%Script for running curvature analysis on a variety of test cases and
%images/image types

%close all

%{
%Circle:
disp('Working...')
%set(0,'DefaultFigureVisible','off');
scaling = 1;
frame = 'D:\Mitch_temp\curvebest.png';
[B,P] = nonbinary_curves(frame,scaling);
%Settings:
Options.Verbose=true;
Options.nPoints = 100; %Number of contour points, default 100 %200 before
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

disp('Executing Snake Method...')
[Vertices,~]=Snake2D(B,P,Options);
disp('Calculating Curvatures...')
k = LineCurvature2D(Vertices);
disp('Determining Normals and Plotting...')
%N=LineNormals2D(Vertices);
newvertsx = Vertices(:,2);
newvertsy = Vertices(:,1);

meank = mean(k);
disp(meank)

%figure
%histogram(k) %histogram for raw curvature values. For excentuated place
%after the gencolor_curves function line.

%set(0,'DefaultFigureVisible','on');
param = meank; %This is a visualization parameter. higher is less harsh. Default .03
[range,newk] = gencolor_curves(newvertsx,newvertsy,k,param,B);
%}

%{
%Ellipse:
disp('Working...')
%set(0,'DefaultFigureVisible','off');
scaling = 1;
frame = 'D:\Mitch_temp\ellipse.png';
[B,P] = nonbinary_curves(frame,scaling);
%Settings:
Options.Verbose=true;
Options.nPoints = 100; %Number of contour points, default 100 %200 before
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

disp('Executing Snake Method...')
[Vertices,~]=Snake2D(B,P,Options);
disp('Calculating Curvatures...')
k = LineCurvature2D(Vertices);
disp('Determining Normals and Plotting...')
%N=LineNormals2D(Vertices);
newvertsx = Vertices(:,2) + 2;
newvertsy = Vertices(:,1) + 1;

meank = mean(k);
disp(meank)

%figure
%histogram(k) %histogram for raw curvature values. For excentuated place
%after the gencolor_curves function line.

%set(0,'DefaultFigureVisible','on');
param = .01; %This is a visualization parameter. higher is less harsh. Default .03
[range,newk] = gencolor_curves(newvertsx,newvertsy,k,param,B);
%}

%{
%Testimg2:
disp('Working...')
%set(0,'DefaultFigureVisible','off');
scaling = 4;
frame = 'testimage2.png';
[B,P] = binary_curves(frame,scaling);
%Settings:
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

disp('Executing Snake Method...')
[Vertices,J]=Snake2D(B,P,Options);
disp('Calculating Curvatures...')
k = LineCurvature2D(Vertices);
disp('Determining Normals and Plotting...')
N=LineNormals2D(Vertices);
newvertsx = Vertices(:,2);
newvertsy = Vertices(:,1);

%figure
%histogram(k) %histogram for raw curvature values. For excentuated place
%after the gencolor_curves function line.

%set(0,'DefaultFigureVisible','on');
param = .01; %This is a visualization parameter. higher is less harsh. Default .03
gencolor_curves(newvertsx,newvertsy,k,param,B)
%}



%Cell/Masks:
disp('Working...')
%progressbar   % Initialize/reset
%progressbar(0)  % Initialize/reset
progressbar() % Initialize/reset and label the bar
%progressbar(0.5) % Update
%progressbar(1) % Close
%set(0,'DefaultFigureVisible','off');
scaling = 7;
frame = 'D:\Mitch_temp\mask_nucleus\frame_0013.tif';
[B,P] = binary_curves(frame,scaling);
progressbar(0.01)
%Settings:
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

disp('Executing Snake Method...')
progressbar(0.1)
[Vertices,~]=Snake2D(B,P,Options);
progressbar(0.7)
disp('Calculating Curvatures...')
k = LineCurvature2D(Vertices);
progressbar(0.8)
disp('Determining Normals and Plotting...')
newvertsx = Vertices(:,2);
newvertsy = Vertices(:,1);

%set(0,'DefaultFigureVisible','on');
progressbar(0.9)
param = .02; %This is a visualization parameter. higher is less harsh. Default .03
gencolor_curves(newvertsx,newvertsy,k,param,B)
progressbar(1)





%{
%Curve4:
disp('Working...')
%set(0,'DefaultFigureVisible','off');
scaling = 3.5;
frame = 'D:\Mitch_temp\curve4.png';
[B,P] = nonbinary_curves(frame,scaling);
%Settings:
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

disp('Executing Snake Method...')
[Vertices,J]=Snake2D(B,P,Options);
disp('Calculating Curvatures...')
k = LineCurvature2D(Vertices);
disp('Determining Normals and Plotting...')
N=LineNormals2D(Vertices);
newvertsx = Vertices(:,2);
newvertsy = Vertices(:,1);

%figure
%histogram(k) %histogram for raw curvature values. For excentuated place
%after the gencolor_curves function line.

%set(0,'DefaultFigureVisible','on');
param = .005; %This is a visualization parameter. higher is less harsh. Default .03
[range,newk] = gencolor_curves(newvertsx,newvertsy,k,param,B);
%}
