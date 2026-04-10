function y = struve(v, z, tol, maxterms)

    arguments
        v
        z
        tol = 10e-16;
        maxterms = 1000000;
    end

    y = zeros(size(z));

    threshold = 40;

    power = abs(z) < threshold;
    asymp = abs(z) > threshold;

    y(power) = struvepower(v, z(power), tol, maxterms);
    y(asymp) = 1.5;

    function y = struvepower(v, z, tol, maxterms)
  
        halffact = sqrt(pi)/2;
        halfz = 0.5.*z;
        arg = halfz.*halfz;
        
    
        finalmult = halfz;
    
        if mod(v,1) == 0
            vprod = halffact;
            for k = 1:v
                vprod = vprod*(k+0.5);
                finalmult = finalmult.*halfz;
            end
        else
            vprod = gamma(v + 1.5);
            finalmult = finalmult.^(v+1);
            disp("noninteger v")
        end
    
        
        % n = 0 term
        dy = 1/(halffact*vprod);
        y = dy;
    
        for n = 1:maxterms
            dy = (-dy.*arg)./((n+0.5)*(n+v+0.5));
            y = y + dy;
            
            if abs(dy) < tol*abs(y)
                break
            end
        end
        
        y = y.*finalmult;

    end
end