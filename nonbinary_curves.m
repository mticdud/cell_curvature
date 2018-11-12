function [B,P] = nonbinary_curves(frame,scaling)
%Function for pre-curvature functions and setting up optimal options
A = imread(frame);
rgb = rgb2gray(A);
binned = imcomplement(imbinarize(rgb));
beast = double(binned);
B = resizem(beast,scaling,'bicubic');
boundsdbl = bwboundaries(binned); %error here
boundmultiply = ((scaling+.1)*boundsdbl{2,1}); %possibly {2,1}
x = boundmultiply(:,1);
y = boundmultiply(:,2);
P=[x(:) y(:)];
end

