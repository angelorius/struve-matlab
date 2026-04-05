function y = struve(v, z, tol, maxterms)

    arguments
        v
        z
        tol = 10e-16;
        maxterms = 1000000;
    end

    halffact = sqrt(pi)/2;
    halfz = 0.5.*z;
    arg = halfz.*halfz;
    

    finalmult = halfz;
    vprod = halffact;

    for k = 1:v
        vprod = vprod*(k+0.5);
        finalmult = finalmult.*halfz;
    end


    % n = 0 term
    dy = 1/(halffact*vprod);
    y = dy;

    if abs(z) < 30
        for n = 1:maxterms
            dy = (-dy.*arg)./((n+0.5)*(n+v+0.5));
            y = y + dy;
            
            if abs(dy) < tol*abs(y)
                break
            end
        end
    else
        y = dy;
    end
    
    y = y.*finalmult;
end