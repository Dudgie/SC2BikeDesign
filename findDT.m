function dt = findDT (theta, omega)
%vector of theta changes (assume the values of theta are not a
    %revolution apart
    dTheta = theta(2:end)-theta(1:end-1);

    %vector of time increments
    dt = dTheta/omega;
    
    %Prevent dividing by zero. for dt of zero, the dTheta must also be zero
    %so it doesn't matter what value of dt the value is set to it just
    %can't be zero.
    for i = 1:length(theta)-1
        if dt(i) == 0
            disp('Dividing by zero');
            dt(i) = 0.000001;
        end
    end
end