clc,clear all
close all
%% data input
load Data_Modaomen.mat
x=[0 21 40 75 96 144]; % distance
%% normalization of the dataset
Zmin=min(z(:,1));Zmax=max(z(:,end));
Zn=(z-Zmin)./(Zmax-Zmin);
Hmin=min(h(:,end));Hmax=max(h(:,1));
Hn=(h-Hmin)./(Hmax-Hmin);
%% Computation of water level distributions
for ii=1:length(Zn)
    Xdata=x;
    Ydata=Zn(ii,:);
    inputs=[Xdata;Ydata]';
    [X_para_z(ii,:),yy_z(ii,:),yy_gradient_z(ii,:),...
        Xdata2,yy2_z(ii,:),yy2_gradient_z(ii,:),...
        x1_z(ii,:),x2_z(ii,:),sigma_z(ii,:)]=...
        f_GUH_waterlevel_distributions(inputs);        
end

%% Computation of tidal range distributions
for ii=1:length(Hn)
    Xdata=x;
    Ydata=Hn(ii,:);
    inputs=[Xdata;Ydata]';
    [X_para_h(ii,:),yy_h(ii,:),yy_gradient_h(ii,:),...
        Xdata2,yy2_h(ii,:),yy2_gradient_h(ii,:),...
        x1_h(ii,:),x2_h(ii,:),sigma_h(ii,:)]=...
        f_GUH_tidalrange_distributions(inputs);        
end

%% reverse of the computed data
yy_z=yy_z*(Zmax-Zmin)+Zmin;
yy_h=yy_h*(Hmax-Hmin)+Hmin;
yy_gradient_z=yy_gradient_z*(Zmax-Zmin)./1000; % convert the distance to meter
yy_gradient_h=yy_gradient_h*(Hmax-Hmin)./1000;

yy2_z=yy2_z*(Zmax-Zmin)+Zmin;
yy2_h=yy2_h*(Hmax-Hmin)+Hmin;
yy2_gradient_z=yy2_gradient_z*(Zmax-Zmin)./1000;
yy2_gradient_h=yy2_gradient_h*(Hmax-Hmin)./1000;

%% Model Calibration
figure;
subplot 121
plot(z,yy_z,'ob');hold on
plot([-0.5 4],[-0.5 4],'--k')
xlim([-0.5 4])
ylim([-0.5 4])
xlabel('Observed \itZ \rm(m)');
ylabel('Computed \itZ \rm(m)');
title('(a) Water level calibration')

subplot 122
h1=plot(h,yy_h,'ob');hold on
h2=plot([0 1.3],[0 1.3],'--k')
xlim([0 1.3])
ylim([0 1.3])
xlabel('Observed \itH \rm(m)');
ylabel('Computed \itH \rm(m)');
title('(b) Tidal range calibration')
legend([h1(1) h2],'Observation','Best fitted','location','best')

%% Comparison between observations and computations
% figure for water level
figure;
for ii=1:length(Zn)
    subplot (4,3,ii)
    yyaxis left
    set(gca,'Ycolor','b');
    h1=plot(x,z(ii,:),'ob');hold on
    h2=plot(Xdata2,yy2_z(ii,:),'-b');hold on
    if rem(ii,3)==1
        ylabel('\itZ \rm(m)')
    end
    yyaxis right
    set(gca,'Ycolor','r');
    h3=plot(Xdata2,yy2_gradient_z(ii,:)*10^5,'-r');hold on
    if rem(ii,3)==0
        ylabel('d\itZ\rm/d\itx \rm(10^{-5})')
    end
    if ii>9
        xlabel('\itx \rm(m)')
    end
    title(['Case ' num2str(ii) ': Water level'])
end
legend([h1 h2 h3],'Observations','Best fitted','d\itZ\rm/d\itx','box','off','orientation','horizontal','Position',[0.58 0.66 0.2 0.6])

% figure for tidal range
figure;
for ii=1:length(Hn)
    subplot (4,3,ii)
    yyaxis left
    set(gca,'Ycolor','b');
    h1=plot(x,h(ii,:),'ob');hold on
    h2=plot(Xdata2,yy2_h(ii,:),'-b');hold on
    if rem(ii,3)==1
        ylabel('\itH \rm(m)')
    end
    yyaxis right
    set(gca,'Ycolor','r');
    h3=plot(Xdata2,yy2_gradient_h(ii,:)*10^5,'-r');hold on
    if rem(ii,3)==0
        ylabel('d\itH\rm/d\itx \rm(10^{-5})')
    end
    if ii>9
        xlabel('\itx \rm(m)')
    end
    title(['Case ' num2str(ii) ': Tidal range'])
end
legend([h1 h2 h3],'Observations','Best fitted','d\itH\rm/d\itx','box','off','orientation','horizontal','Position',[0.58 0.66 0.2 0.6])
