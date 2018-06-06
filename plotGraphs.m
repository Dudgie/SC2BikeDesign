function [stroke,Maximum] = plotGraphs(f2,calfExtension,Mc,k,N,x,y,f3,V,Flt)
    figure(f2);
    stroke = plot(calfExtension,Mc);%,'Color',[0,k/(2*N),(N-k)/(2*N)]);
    hold on
    xlabel('Extension Rate / rad/s')
    ylabel('Calf Moment / Nm')
    title('Graph of the supplied moment from the calf vs the extension rate of the calf')
    scatter(calfExtension(1,1),Mc(1,1),'r','x');
    
    Maximum = plot(x,y,'black');
    
    
    
    figure(f3);
    plot(V(1,:),Flt,'Color',[1 k/N 0]);
    hold on
    xlabel('ankle tangential velocity');
    ylabel('tangential force on the ankle');
end