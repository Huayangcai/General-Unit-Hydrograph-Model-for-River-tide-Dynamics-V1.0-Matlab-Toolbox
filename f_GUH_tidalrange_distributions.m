function [X,yy,yy_gradient,Xdata2,yy2,yy2_gradient,X1,X2,sigma]=f_GUH_tidalrange_distributions(inputs)

%% Tidal range distribution
xdata=inputs(:,1); % distance
ydata=inputs(:,2); % tidal range
x0=[50 10 1]; % default value for xp, mu and m, respectively.

% calculations
% p(1), p(2) and p(3) represent xp, mu and m, respectively.
y=@(p,x) exp(p(2)*(x/p(1)-1));
g=@(p,x) 1./(1+p(3)*y(p,x)).^(1/p(3));
u=@(p,x) -p(2)/p(1).*y(p,x)./(1+p(3).*y(p,x)).^(1+1./p(3));
x1=@(p,t) p(1).*(1+(log(0.5*((p(3)+3)-sqrt(p(3).^2+6*p(3)+5))))./p(2));
x2=@(p,t) p(1).*(1+log(0.5*((p(3)+3)+sqrt(p(3).^2+6*p(3)+5)))./p(2));

lb = [0,0,0]; % lower boundary for coefficients
ub = [max(xdata),100,100];% upper boundary for coefficients
[X,resnorm] = lsqcurvefit(g,x0,xdata,ydata,lb,ub); % regression fitting
yy=g(X,xdata); % computed tidal range
yy_gradient=u(X,xdata); % computed tidal range gradient

% spatial distributions of tidal range along the channel
Xdata2=linspace(0,150,1001);
yy2=g(X,Xdata2);
yy2_gradient=u(X,Xdata2);

% the two inflection points and their deviation to xp
X1=x1(X);X2=x2(X);sigma=0.5*(X2-X1);
end