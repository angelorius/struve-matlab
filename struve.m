function y = struve(v, z, tol, maxterms)

    arguments
        v
        z
        tol = 10e-16;
        maxterms = 1000000;
    end

    y = 0;
    halffact = sqrt(pi)/2;
    halfz = 0.5.*z;
    arg = halfz.*halfz;
    finalmult = halfz;


    vprod = halffact;

    for k = 1:v
        vprod = vprod*(k+0.5);
        finalmult = finalmult.*halfz;
    end


    done = false;

    for n = 0:maxterms
        dy = 1;
        dy = dy/(halffact*vprod);

        for m = 1:n
            dy = (-dy.*arg)./((m+0.5)*(m+v+0.5));

            if abs(dy) < tol
                done = true;
            end
        end

        if done
            break
        end

        y = y + dy;
    end
    
    y = y.*finalmult;
end