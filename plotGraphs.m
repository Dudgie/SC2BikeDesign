function plotGraphs(f2,calfExtension,Mc,k,N,x,y,f3,V,Flt)
    figure(f2);
    plot(calfExtension,Mc,'Color',[1 k/N 0]);
    hold on
    xlabel('Extension Rate')
    ylabel('Calf Force')
    title('Graph of the supplied force from the calf vs the extension rate of the calf')

    plot(x,y);

    figure(f3);
    plot(V(1,:),Flt,'Color',[1 k/N 0]);
    hold on
    xlabel('ankle tangential velocity');
    ylabel('tangential force on the ankle');
end