function y= cardinality(V,ht,wt,dt)

    y = zeros(ht,wt,dt);
    
    % Create Padding on all sides
    V_paded = padarray(V,[1 1 1],0,'both');

    for a=1:ht
        for b=1:wt
            for c=1:dt
                sum=0.00;
                for p=1:3
                    for q=1:3
                        for r=1:3
                            sum = sum + V_paded((p+a-1),(q+b-1),(r+c-1));
                        end
                    end
                end
                y(a,b,c)=sum;
            end
        end
    end
end