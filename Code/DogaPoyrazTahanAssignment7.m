




%% Initialization
clear ; close all; clc
%% ======================= Part 1: Data Reading =======================
data = load('data_training.txt');
data2 = load('data_validation.txt');
X = data(:, 1); Y = data(:, 2);
m = length(Y); % number of training examples
XT = data2(:, 1); YT = data2(:, 2);
mT = length(YT); % number of training examples

%% ======================= Part 1.1: Plotting =======================
% Plot Data
% Note: You have to complete the code in plotData.m
plotData(X, Y);
hold on
scatter(XT,YT,3,[0,0,0.5]);
hold off
pOrg = [3,-2,1];
xx = linspace(-8,13,200);
ff = polyval(pOrg,xx);
hold on
%plot(xx,ff);
hold off
%% ======================= Part 2: Analytical Solution =======================

plotData(X,Y);
sumErr = zeros(20,1);
sumErrT = zeros(20,1);
for i= 1:20
    
    [p,S,mu]=polyfit(X,Y,i);
    f = polyval(p,X,[],mu);
    T = table(X,Y,f,(Y-f).^2,'VariableNames',{'X','Y','Fit','FitError'});
    ErrColumn = T{:,{'FitError'}};
    sumErr(i)= sum(ErrColumn)/length(X);
    
    [p1,S1,mu1]=polyfit(XT,YT,i);
    ftest = polyval(p1,XT,[],mu1);
    Ttest = table(XT,YT,ftest,(YT-ftest).^2,'VariableNames',{'X','Y','Fit','FitError'});
    
    ErrColumn = Ttest{:,{'FitError'}};
    
    sumErrT(i) = sum(ErrColumn)/length(YT);
    
    if i==1 || i==3|| i==4|| i==14|| i==20
        ff = polyval(p,xx,[],mu);
        hold on
        plot(xx,ff);
        hold off
    end
end

figure;
plot(sumErr);
hold on
plot(sumErrT);
hold off

minDegree = 1;

for i = 2:20
   if sumErrT(i-1)>sumErrT(i)
      minDegree = i;
   end
end

[p,S,mu]=polyfit(X,Y,minDegree);

for i = 1:minDegree
    fprintf('+(%f)x^%d',p(i),(i-1))
end

