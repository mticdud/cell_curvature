function gencolor_curves(newvertsx,newvertsy,k,param,B)
%[range,k] = can be added??
%Function for determining colormap parameters to be overlaid
n = 128;
myColorMap = [linspace(0,1,n)' linspace(0,1,n)', ones(n,1); ones(n,1) linspace(1,0,n)' linspace(1,0,n)'];
Colorsize = size(myColorMap,1);

k(k < -param) = -param;
k(k > param) = param;

minC = min(k);
maxC = max(k);
range = maxC-minC;


numcurv = size(k,1);
Indtests = zeros(numcurv,1);
for i=1:numcurv
    Indtests(i) = round(Colorsize*(k(i)-minC)/range);
end

%B = imread(B); %only need if doing cell and not masks

figure, 
imshow(B,'InitialMagnification',25) %25 change based on size of original image
hold on;

for j=1:numcurv
    if Indtests(j) == 0
        Indtests(j) = 1;
    end
    if isnan(Indtests(j))
        Indtests(j) = 1;
    end
    Color = myColorMap(Indtests(j),:);
    plot(newvertsx(j), newvertsy(j), '.', 'MarkerSize', 7, 'Color', Color);
end
hold off;
end

