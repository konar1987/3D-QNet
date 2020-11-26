function a= check(w1,w2,ht,wt,dt)
 for p=1:ht
    for q=1:wt
        for r=1:dt
           x=abs(w2(p,q,r)-w1(p,q,r));
           if(x < 10e-8)   % changes made
              a=1;          
           else
              a=0;
              break;
           end
        end
    end
 end

