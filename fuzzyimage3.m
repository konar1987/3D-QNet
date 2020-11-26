function out_matrix= fuzzyimage3(V)
    
    %for lamb=0.240:-001: 0.230
    lamb=0.232;
    dim = size(V);
    wt=dim(1); %wt = 240
    ht=dim(2); %ht = 240
    dt=dim(3); %dt = 155

    in_matrix = V;
    
    [int_matrix,~]=Transit(in_matrix,ht,wt,dt,lamb);  % I1 ---> I2
   
    [out_matrix,w1]=Transit(int_matrix,ht,wt,dt,lamb);   % I2 ---> I3  
   
    a=0;
    count=0;
    while(a==0)
        [int_matrix,~]=Transit(out_matrix,ht,wt,dt,lamb);   % I3 ---> I2
        [out_matrix,w2]=Transit(int_matrix,ht,wt,dt,lamb);  % I2 ---> I3
        a=check(w1,w2,ht,wt,dt);
        disp(a);
      
        w1=w2;

        count=count+1;
        disp(count); 

        if(count>=50)
            break;
        end
    end
    
    % Rescale double to uint8 before saving
    out_matrix = im2int16(rescale(out_matrix));
    
%     for j = 1:dt
%         filename=sprintf('Slice%d.png',j-1);
%         imwrite(out_matrix(:,:,j),strcat(output_loc,filename));
%     end
   
end
        
    