clear
clc

filedir='D:\LargeData\CarbonData\';
load([filedir,'Biomass\ornl\biomass.mat']) % biomass
load([filedir,'CRU\CRU.mat']) % climate
load([filedir,'HWSD\LC.mat']) % soil and land cover

[LONL,LATL]=meshgrid(lonl,latl);
[LATCRU,LONCRU]=meshgrid(lat_cru,lon_cru);
pre=interp2(LATCRU,LONCRU,pre,LATL,LONL);
pet=interp2(LATCRU,LONCRU,pet,LATL,LONL);

% carbon============================================
di=pet./pre;di(di>100)=nan;
cc=bm*0.1+soc*10;
%cc=soc*0.1;
cc(lc==15 | lc==13)=nan;
[x,y,ypct,ystd] = f_binning2(reshape(di,1,[]),reshape(cc,1,[]),0.1,25,31);
jbfill(x,ypct(3,:),ypct(1,:),[188,189,220]./255,[188,189,220]./255,1,0.6);
hold on
plot(x,y,'ko','linewidth',1.2)
f=fit(x',y','a*x^-b')
plot(x,f(x),'k','linewidth',1.2,'HandleVisibility','off')
corrcoef(y,f(x))
plot(x,ystd,'r^','linewidth',1.2)
f=fit(x',ystd','a*x^b')
corrcoef(ystd,f(x))
plot(x,f(x),'r','linewidth',1.2,'HandleVisibility','off')
set(gca, 'XScale','log', 'YScale','log')
legend('Q1-Q3','$\mu_C$','$\sigma_C$','interpreter','latex','location','northeast')
legend boxoff
box on
xlabel('$D_I$','interpreter','latex')
ylabel('Total Carbon (Mg ha$^{-1}$)','interpreter','latex')
yticks([50,100,200])

