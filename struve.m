function y = struve(v, z, tol, maxterms)

    arguments
        v
        z
        tol = 1e-16;
        maxterms = 1000000;
    end

    y = zeros(size(z));

    threshold = 30;

    power = abs(z) <= threshold;
    asymp = abs(z) > threshold;

    y(power) = struvepower(v, z(power), tol, maxterms);
    y(asymp) = struveasymp(v, z(asymp), tol, maxterms);

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
            finalmult = halfz.^(v+1);
            disp("noninteger v")
        end
    
        
        % n = 0 term
        dy = ones(size(arg))/(halffact*vprod);
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

    function y = struveasymp(v, z, tol, maxterms)
        
        minushalffact = sqrt(pi);
        halfz = 0.5.*z;
        arg = 1./(halfz.*halfz);
        
    
        finalmult = 1./halfz;
    
        if mod(v,1) == 0
            vprod = minushalffact;
            for k = 1:v
                vprod = vprod*(k-0.5);
                finalmult = finalmult.*halfz;
            end
        else
            vprod = gamma(v + 0.5);
            finalmult = halfz.^(v-1);
            disp("noninteger v")
        end
    
        
        % n = 0 term
        dy = minushalffact./vprod.*ones(size(z));
        dyprev = ones(size(z));
        Y = bessely(v,z);
        y = dy;
        active = true(size(z));
    
        for n = 1:maxterms
            dyprev(active) = dy(active);
            dy(active) = (v-0.5-n).*(n-0.5).*dy(active).*arg(active);

            diverging = abs(dy) > abs(dyprev);
            active = active & ~diverging;

            y(active) = y(active) + dy(active);
            
            if ~any(active) || all(abs(dy(active)) < tol*abs(Y(active)))
                break
            end
        end
        
        y = (y.*finalmult)./pi;
        y = y + Y;

    end
end