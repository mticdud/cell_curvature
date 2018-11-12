function [B,P] = binary_curves(frame,scaling)
%Function for pre-curvature functions and setting up optimal options
A = imbinarize(imread(frame));
beast = double(A);
B = resizem(beast,scaling,'bicubic');
boundsdbl = bwboundaries(A);
boundmultiply = ((scaling+.1)*boundsdbl{1,1});
x = boundmultiply(:,1);
y = boundmultiply(:,2);
P=[x(:) y(:)];
end

