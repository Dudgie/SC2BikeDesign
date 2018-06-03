function findForceDisplacement(m)
    Scale = 4;
    m = m*Scale;
    
    % Get file to read
    [dfile,dpath] = uigetfile('*.dat','Select Data File To Load');
    dataFile = fullfile(dpath, dfile);
    M = csvread(dataFile);
    t = M(1,:);
    z = M(2,:);
    
    v = (z(2:end)-z(1:end-1))./(t(2:end)-t(1:end-1));
    tS = (t(1:end-1)+t(2:end))/2;
    a = (v(2:end)-v(1:end-1))./(tS(2:end)-tS(1:end-1));
    
    F = m*9.81+m*a;
    vS = (v(1:end-1)+v(2:end))/2;
    data = scatter(vS,F);
    hold on
    xlabel('Velocity of the mass / ms^(-1)')
    ylabel('Foce from the calf / N');
    title('Calf force velocity characteristic');
    legend(data,'Data')
end