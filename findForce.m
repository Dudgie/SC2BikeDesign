function moment = findForce(extensionRate,PlotIt)
    M = [100,73,40,24,20,18,17];
    E = [0,0.6,1.3,2.2,3.0,3.8,4.7];
    
    moment = interp1(E,M,extensionRate);
    
    if PlotIt
        plot(E,M);
        xlabel('Extension Rate / rad/s');
        ylabel('Moment / Nm');
        title('Force vs Extension Rate');
    end
end