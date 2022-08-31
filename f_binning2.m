function [x,y,ypct,ystd] = f_binning2(X,Y,Xmin,Xmax,N)
Xbnd=linspace(Xmin,Xmax,N);
x=( Xbnd(1:end-1) + Xbnd(2:end) )./2;
y=nan(1,length(Xbnd)-1);
ystd=nan(1,length(Xbnd)-1);
ypct=nan(3,length(Xbnd)-1);

for ii=1:length(Xbnd)-1
    index=~isnan(X) & ~isnan(Y) & X>Xbnd(ii) & X<Xbnd(ii+1);
    if sum(index)<100
        continue
    end
    y(ii)=mean( Y(index) );
    ypct(:,ii) = prctile(Y(index),[25,50,75])';
    ystd(ii) = std( Y(index) );
end

end

